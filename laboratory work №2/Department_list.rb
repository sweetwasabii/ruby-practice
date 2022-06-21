# 3.1 Создать класс Department_list, в котором будет поле массив объектов класса Department.
# Создать коструктор, инициализирующий это поле.

class Department_list
  attr_reader :department_list

  def initialize(*departments)
    @department_list = []
    departments.each {|department| add_department(department)}
  end

  def add_department(department)
    @department_list.push(Department)
  end
end