=begin

1.1 Создать класс Department с полями объекта название, контактный телефон.
Написать конструктор, геттеры и сеттеры. Избежать дублирования кода.
Рассмотреть способы реализации геттеров и сеттеров с помощью символов.

5.1 В класс Department добавьте поле Post_list.
Обновите конструктор.

5.2 Напишите методы:
добавить должность,
выбрать должность,
удалить должность,
изменить должность.

=end

require_relative "Post_list.rb"

class Department
  attr_reader :name, :phone_number, :duties, :marking_duty_index, :posts

  def initialize(name, phone_number, duties, posts)
    @name = set_name(name)
    @phone_number = set_phone_number(phone_number)
    @duties = []
    @posts = []

    duties.each { |duty| add_duty(duty) }
    posts.each { |post| posts.add_note(post)}
  end

  # формат имени: состоит только из букы
  def set_name(new_name)
    @name = new_name.capitalize
=begin
    if new_name.size > 0 and
      new_name.scan(/[^А-ЯA-Zа-яa-z]/).empty?
      @name = new_name.capitalize
    else
      raise ArgumentError, "The name is incorrect"
    end
=end
  end

  # формат номера: +7 (918) 648-07-50
  def set_phone_number(new_phone_number)
    if new_phone_number.size == 18 and
      (new_phone_number =~ /\+7\s\(\d{3}\)\s\d{3}-\d{2}-\d{2}/) == 0
      @phone_number = new_phone_number
    else
      raise ArgumentError, "The phone number is incorrect"
    end
  end

  # добавление обязанности: по тексту
  def add_duty(duty_text)
    unless @duties.include?(duty_text)
      @duties.push(duty_text)
    end
  end

  # удаление обязанности: по индексу
  def delete_duty(duty_index)
    duty_index -= 1
    if (0..@duties.size - 1).include?(duty_index)
      @duties.delete_at(duty_index)
    end
  end

  # выделение обязанности: по индексу
  def mark_duty(duty_index)
    duty_index -= 1
    if (0..@duties.size - 1).include?(duty_index)
      @marking_duty_index = duty_index
    end
  end

  # получение текста выделенносй обязанности
  def get_marking_duty_text
    if (0..@duties.size - 1).include?(@marking_duty_index)
      return @duties[@marking_duty_index]
    end
  end

  # замена текста выделенносй обязанности
  def replace_marking_duty_text(text)
    if (0..@duties.size - 1).include?(@marking_duty_index)
      @duties[@marking_duty_index] = text
    end
  end

  def get_duties_to_s
    s = ""
    unless @duties.empty?
      s += "Обязанности:\n\n"
      @duties.each_index { |index|
        s += "#{index + 1}. #{@duties[index]};\n"
      }
    end
    return s
  end

  def print_duties
    puts get_duties_to_s
  end

  def to_s
    return "Отдел: #{@name}\n" + "Номер: #{@phone_number}\n" +
      ((get_duties_to_s == "")? "": "\n" + get_duties_to_s)
  end

  def add_post(post)
    posts.add_note(post)
  end

  def delete_post
    posts.delete_note
  end

  def choose_post(post_index)
    posts.choose_note(post_index)
  end

  def change_post
    posts.change_note
  end
end