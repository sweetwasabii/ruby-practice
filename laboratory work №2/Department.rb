=begin

1. Создать класс Department с полями объекта название, контактный телефон.
Написать конструктор, геттеры и сеттеры. Избежать дублирования кода.
Рассмотреть способы реализации геттеров и сеттеров с помощью символов.

=end

=begin

СПРАВКА

Строго говоря, классы в Ruby не имеют имен.
«Имя» класса — это всего лишь константа, ссылающаяся на объект типа Class

=end

class Department
  attr_reader :name, :phone_number, :duties, :marking_duty_index

  def initialize(name, phone_number, *duties)
    @name, @phone_number, @duties = name, phone_number, duties
  end

  # формат имени: состоит только из букы
  def name=(new_name)
    if new_name.size > 0 and
      new_name.scan(/[^А-ЯA-Zа-яa-z]/).empty?
      @name = new_name.capitalize
    end
  end

  # формат номера: +7 (918) 648-07-50
  def phone_number=(new_phone_number)
    if new_phone_number.size == 18 and
      (new_phone_number =~ /\+7\s\(\d{3}\)\s\d{3}-\d{2}-\d{2}/) == 0
      @phone_number = new_phone_number
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
end

# 2. Создать несколько объектов, вывести информацию о них на экран.
# Продумать корректный способ вывода информации о текущем состоянии объекта на экран.

sales = Department.new("Продажи", "+7 (996) 683-72-88",
                       "Предлагать покупателям новые продукты",
                       "Проводить встречи с потенциальными клиентами")
accounting = Department.new("Бухгалтерия", "+7 (999) 529-23-57",
                            "Подводить итоги в 19:00",
                            "Заносить данные о покупах")
development = Department.new("Разработка", "+7 (992) 453-69-95",
                             "Разрабатывать новые решение для улучшения производительности",
                             "Проводить тестирования новых решений")

puts sales.to_s + "\n" + accounting.to_s + "\n" + development.to_s

# 3. Создать поле выполнение обязанностей.
#
# Реализовать методы:
# добавить обязанность,
# выделить обязанность,
# удалить обязанность,
# получить текст выделенной обязанности,
# заменить текст выделенной обязанности,
# вывести список обязанностей на экран.
#
# Объяснить, почему с точки зрения основных принципов ООП
# нежелательно получать доступ к массиву целиком.
# Продумать, каким должен быть в этом случае конструктор и внести изменения.

sales.add_duty("Устраивать рекламные акции")
development.mark_duty(1)
accounting.delete_duty(1)

puts "\n" + development.get_marking_duty_text + "\n\n"

development.replace_marking_duty_text("Разрабатывать новые решение для улучшения эффективности")
development.print_duties

puts "\n" + sales.to_s + "\n" + accounting.to_s + "\n" + development.to_s