=begin

2.1 Продумайте структуру текстового файла, в котором будут
храниться объекты класса Department. Напишите такой файл.

ФОРМАТ:

имя
номер
обязанности (каждая с новой строки)

отделы через пустую строку

=end

=begin

# 2.2 Напишите метод, который читает read_from_txt,
# который читает несколько отделов из текстового файла и возвращает массив объектов класса Department.

=end

require "yaml"
require_relative "Department.rb"
require_relative "Department_list.rb"

def read_from_txt(file_name)
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
  return departments
end

def write_to_txt(departments, file_name)
  file = File.new(file_name, "w:UTF-8")
  departments.each { |department|
    output = department.name + "\n" + department.phone_number + "\n"
    department.duties.each { |duty| output += duty + "\n"}
    file.print("#{output}\n")
  }

  file.close
end

def print_departments(departments)
  departments.each { |department| puts "#{department}\n"}
end

def write_to_YAML(departments, file_name)
  file = File.new(file_name, "w:UTF-8")
  file.print(departments.to_yaml)

  file.close
end

def read_from_YAML(file_name)
  file = File.new(file_name, "r:UTF-8")
  content = file.read

  departments = YAML.load(content)

  file.close
  return departments
end


# 2.3 Написать метод, который выводит массив объектов класса Department на экран.

# departments = read_from_txt("input_departments.txt")
# print_departments(departments)

# 2.4 Написать метод write_to_txt, который записывает массив объектов класса Department в файл txt.

# departments = read_from_txt("input_departments.txt")
# write_to_txt(departments, "output_departments.txt")

# 2.5 Прочитать массив объектов, вывести на экран, добавить еще один отдел,
# вывести результат на экран, записать измененный массив в тот же файл.

=begin
departments = read_from_txt("input_departments.txt")
print_departments(departments)

departments.push(Department.new("Аналитика", "+7 (918) 648-07-50", "Проводить опросы"))
print_departments(departments)

write_to_txt(departments, "input_departments.txt")
=end

# 2.6 Написать метод write_to_YAML, который записывает массив объектов класса Department в файл YAML.

# departments = read_from_txt("input_departments.txt")
# write_to_YAML(departments, "input_yaml.yml")

# 2.7 Напишите метод, который читает read_from_YAML,
# который читает несколько отделов из YAML файла и возвращает массив объектов класса Department.

# departments = read_from_YAML("input_yaml.yml")
# print_departments(departments)

# 2.8 Прочитать массив объектов, вывести на экран, добавить еще один отдел,
# вывести результат на экран, записать измененный массив в тот же файл.

=begin
departments = read_from_YAML("input_yaml.yml")
print_departments(departments)

departments.push(Department.new("Аналитика", "+7 (918) 648-07-50", "Проводить опросы"))
print_departments(departments)

write_to_YAML(departments, "output_yaml.yml")
=end

departments = read_from_txt("input_departments.txt")
department_list = Department_list.new(departments)