=begin

3.1 Создать класс Department_list, в котором будет поле массив объектов класса Department.
Создать коструктор, инициализирующий это поле.

3.2 Написать методы:

add_note, добавляющий запись,
метод choose_note, выделяющий запись,
метод change_note, заменяющий выбранную запись,
метод get_note, возвращающий выбранную запись
delete_note, удаляющий выбранную запись.

3.3 Реализовать методы сериализации и десериализации.

3.4 Построить конструктор, читающий объект из YAML и коструктор, читающий объект из TXT.
Как реализовать такие кострукторы, при условии, что переопределение конструкторов в ruby невозможно?

3.5 Построить метод, сортирующий записи по названию.

=end

require "yaml"
require_relative "Department.rb"

class Department_list
  # поля: department_list, marking_department_index
  attr_reader :marking_department_index

  def initialize
    @department_list = []
    @marking_department_index = -1
  end

  # def Department_list.txt(file_name)
  #   file = File.new(file_name, "r:UTF-8")
  #   content = file.read
  #
  #   departments = []
  #   content.strip.split("\n\n").each { |result|
  #     department = result.split("\n")
  #     name = department[0]
  #     phone_number = department[1]
  #     duties = department.slice(2..department.size - 1)
  #
  #     departments.push(Department.new(name, phone_number, *duties))
  #   }
  #
  #   file.close
  #   new(*departments)
  # end

  # def Department_list.yaml(file_name)
  #   file = File.new(file_name, "r:UTF-8")
  #   content = file.read
  #
  #   file.close
  #   new(*YAML.load(content))
  # end

  def get_department_names
    return @department_list.map { |department| department.name}
  end

  def add_department(department)
    if get_department_names.include?(department.name)
      raise ArgumentError, "This department \"#{department.name}\" already exists"
    else
      @department_list.push(department)
    end
  end

  def is_index_correct(index, list)
    return (0..list.size - 1).include?(index)
  end

  # индексация у пользователя начинается с 1
  def mark_department(department_index)
    department_index -= 1
    if is_index_correct(department_index, @department_list)
      @marking_department_index = department_index
    else
      raise ArgumentError, "The department index #{department_index + 1} is incorrect"
    end
  end

  def replace_department(new_department)
    if get_department_names.include?(new_department.name)
      raise ArgumentError, "This department \"#{new_department.name}\" already exists"
    elsif is_index_correct(@marking_department_index, @department_list)
      @department_list[@marking_department_index] = new_department
    else
      raise ArgumentError, "The marking department index #{@marking_department_index + 1} is incorrect"
    end
  end

  def get_department
    if is_index_correct(@marking_department_index, @department_list)
      return @department_list[@marking_department_index]
    else
      raise ArgumentError, "The marking department index #{@marking_department_index + 1} is incorrect"
    end
  end

  def delete_department
    if is_index_correct(@marking_department_index, @department_list)
      @department_list.delete_at(@marking_department_index)
      @marking_department_index = -1
    else
      raise ArgumentError, "The marking department index #{@marking_department_index + 1} is incorrect"
    end
  end

  # def write_to_YAML(file_name)
  #   file = File.new(file_name, "w:UTF-8")
  #   file.print(@notes_list.to_yaml)
  #
  #   file.close
  # end
  #
  # def write_to_txt(file_name)
  #   file = File.new(file_name, "w:UTF-8")
  #   @notes_list.each { |department|
  #     output = department.name + "\n" + department.phone_number + "\n"
  #     department.duties.each { |duty| output += duty + "\n"}
  #     file.print("#{output}\n")
  #   }
  #
  #   file.close
  # end

  def sort
    @department_list.sort! { |department1, department2| department1.name <=> department2.name }
  end

  def to_s
    s = ""
    @department_list.each_index {|i|
      s += "№#{i + 1} #{@department_list[i]}\n"
    }
    return s
  end
end

begin
  sales = Department.new("Продажи", "+7 (996) 683-72-88")
  sales.add_duty("Предлагать покупателям новые продукты")
  sales.add_duty("Проводить встречи с потенциальными клиентами")
  sales.add_duty("Устраивать рекламные акции")

  accounting = Department.new("Бухгалтерия", "+7 (999) 529-23-57")
  accounting.add_duty("Подводить итоги в 19:00")
  accounting.add_duty("Заносить данные о покупах")

  development = Department.new("Разработка", "+7 (992) 453-69-95")
  development.add_duty("Разрабатывать новые решение для улучшения производительности")
  development.add_duty("Проводить тестирования новых решений")

  departments = Department_list.new
  departments.add_department(sales)
  departments.add_department(accounting)

  departments.mark_department(2)
  # departments.replace_marking_department(development)
  departments.add_department(development)

  # puts departments.get_department.to_s

  # departments.delete_department

  departments.sort
  puts departments.to_s
rescue ArgumentError => error
  puts "Error: " + error.message + "."
end
