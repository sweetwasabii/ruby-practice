# 3.1 Создать класс Department_list, в котором будет поле массив объектов класса Department.
# Создать коструктор, инициализирующий это поле.

# 3.2 Написать методы:
# add_note, добавляющий запись,
# метод choose_note, выделяющий запись,
# метод change_note, заменяющий выбранную запись,
# метод get_note, возвращающий выбранную запись
# delete_note, удаляющий выбранную запись.

# 3.3 Реализовать методы сериализации и десериализации.

class Department_list
  attr_reader :notes_list, :chosen_note_index

  def initialize(*notes)
    @notes_list = []
    notes.each {|note| add_note(note)}
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

  def read_from_YAML(file_name)
    file = File.new(file_name, "r:UTF-8")
    content = file.read

    @notes_list = YAML.load(content)
    file.close
  end
end