=begin

4.1 Создайте класс должность Post с полями
отдел, название, оклад, должность вакантна или нет.

Реализуйте геттеры, сеттеры и конструктор.
Объясните принцип построения. Реализуйте способ вывода должности на экран.

=end

class Post
  attr_accessor :department, :name, :salary, :is_free

  def initialize(department, name, salary, is_free)
    @department, @name, @salary, @is_free = department, name, salary, is_free
  end

  def to_s
    return "Должность: #{@name}\n" + "Зарплата: #{salary}\n" +
      "Вакантно: " + ((@is_free == true)? "Да": "Нет") + "\n\n" + department.to_s
  end
end