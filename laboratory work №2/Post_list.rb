# 4.2 По аналогии с классом Department_list напишите класс Post_list.

require_relative "Post.rb"
require_relative "Department.rb"

class Post_list
  attr_reader :notes_list, :chosen_note_index

  def initialize(*notes)
    @notes_list = []
    notes.each {|note| add_note(note)}
  end

  def Post_list.txt(file_name)
    file = File.new(file_name, "r:UTF-8")
    content = file.read

    posts = []
    content.strip.split("\n\n").each { |result|
      post = result.split("\n")
      name = post[0]
      salary = post[1]
      is_free = (post[2] == "Да")? true: false
      department = Department.new(*post.slice(3..post.size - 1))

      posts.push(Post.new(department, name, salary, is_free))
    }

    file.close
    new(*posts)
  end

  def Post_list.yaml(file_name)
    file = File.new(file_name, "r:UTF-8")
    content = file.read

    file.close
    new(*YAML.load(content))
  end

  def is_index_correct(note_index)
    return (0..@notes_list.size - 1).include?(note_index)
  end

  def add_note(note)
    unless @notes_list.include?(note)
      @notes_list.push(note)
    end
  end

  def choose_note(note_index)
    note_index -= 1
    if is_index_correct(note_index)
      @chosen_note_index = note_index
    end
  end

  def change_note(note)
    if is_index_correct(@chosen_note_index)
      @notes_list[@chosen_note_index] = note
    end
  end

  def get_note
    if is_index_correct(@chosen_note_index)
      return @notes_list[@chosen_note_index]
    end
  end

  def delete_note
    if is_index_correct(@chosen_note_index)
      @notes_list.delete_at(@chosen_note_index)
    end
  end

  def write_to_YAML(file_name)
    file = File.new(file_name, "w:UTF-8")
    file.print(@notes_list.to_yaml)

    file.close
  end

  def write_to_txt(file_name)
    file = File.new(file_name, "w:UTF-8")
    @notes_list.each { |post|
      output = post.name + "\n" + post.salary + "\n" + ((post.is_free)? "Дa": "Нет") + "\n"
        post.department.name + "\n" + post.department.phone_number + "\n"
      post.department.duties.each { |duty| output += duty + "\n"}
      file.print("#{output}\n")
    }

    file.close
  end

  def sort
    @notes_list.sort! { |note1, note2| note1.name <=> note2.name }
  end

  def to_s
    notes = ""
    @notes_list.each {|note| notes += "#{note}\n"}
    return notes
  end
end