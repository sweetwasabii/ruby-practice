# 3.1 Создать класс Department_list, в котором будет поле массив объектов класса Department.
# Создать коструктор, инициализирующий это поле.

# 3.2 Написать методы:
# add_note, добавляющий запись,
# метод choose_note, выделяющий запись,
# метод change_note, заменяющий выбранную запись,
# метод get_note, возвращающий выбранную запись
# delete_note, удаляющий выбранную запись.

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
    @notes_list.push(note)
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
end