# 3.1 Создать класс Department_list, в котором будет поле массив объектов класса Department.
# Создать коструктор, инициализирующий это поле.

# 3.2 Написать методы:
# add_note, добавляющий запись,
# метод choose_note, выделяющий запись,
# метод change_note, заменяющий выбранную запись,
# метод get_note, возвращающий выбранную запись
# delete_note, удаляющий выбранную запись.

# 3.3 Реализовать методы сериализации и десериализации.

# 3.4 Построить конструктор, читающий объект из YAML и коструктор, читающий объект из TXT.
# Как реализовать такие кострукторы, при условии, что переопределение конструкторов в ruby невозможно?

# 5. Построить метод, сортирующий записи по названию.

require "yaml"
require_relative "Department.rb"

class Department_list
  attr_reader :notes_list, :chosen_note_index

  def initialize(*notes)
    @notes_list = []
    notes.each {|note| add_note(note)}
  end

  def Department_list.txt(file_name)
    file = File.new(file_name, "r:UTF-8")
    content = file.read

    departments = []
    content.strip.split("\n\n").each { |result|
      department = result.split("\n")
      name = department[0]
      phone_number = department[1]
      duties = department.slice(2..department.size - 1)

      departments.push(Department.new(name, phone_number, *duties))
    }

    file.close
    new(*departments)
  end

  def Department_list.yaml(file_name)
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
    @notes_list.each { |department|
      output = department.name + "\n" + department.phone_number + "\n"
      department.duties.each { |duty| output += duty + "\n"}
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