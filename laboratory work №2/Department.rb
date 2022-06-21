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
  attr_reader :name, :phone_number

  def initialize(name, phone_number)
    @name, @phone_number = name, phone_number
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

  def to_s
    return "Отдел: #{@name}\n" + "Номер: #{@phone_number}\n"
  end
end

# 2. Создать несколько объектов, вывести информацию о них на экран.
# Продумать корректный способ вывода информации о текущем состоянии объекта на экран.

sales = Department.new("Продажи", "+7 (996) 683-72-88")
accounting = Department.new("Бухгалтерия", "+7 (999) 529-23-57")
development = Department.new("Разработка", "+7 (992) 453-69-95")

puts sales.to_s + "\n" + accounting.to_s + "\n" + development.to_s