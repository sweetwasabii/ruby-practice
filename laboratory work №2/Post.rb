=begin

4.1 Создайте класс должность Post с полями
отдел, название, оклад, должность вакантна или нет.

Реализуйте геттеры, сеттеры и конструктор.
Объясните принцип построения. Реализуйте способ вывода должности на экран.

=end

class Post
  # поля: department_name, post_name, salary, is_free
  attr_accessor :salary, :is_free
  attr_writer :department_name, :post_name

  def initialize(department_name, post_name, salary, is_free)
    @department_name, @post_name, @salary, @is_free = department_name, post_name, salary, is_free
  end

  def department_name
    return @department_name.clone
  end

  def post_name
    return @post_name.clone
  end

  def to_s
    return "Отдел: #{@department_name}\n"+ "Должность: #{@post_name}\n" +
      "Зарплата: #{@salary}\n" + "Вакантно: " + ((@is_free == true)? "Да": "Нет") + "\n"
  end
end

# post1 = Post.new("Продажи", "Младший менеджер", 55000, false)
# post2 = Post.new("Продажи", "Старший менеджер", 80000, true)
# post3 = Post.new("Бухгатерия", "Бухгалтер", 40000, false)
# post4 = Post.new("Разработка", "Разработчик", 100000, false)
#
# puts post1.to_s + post2.to_s + post3.to_s + post4.to_s
