require_relative "Department.rb"
require_relative "Department_list.rb"

require_relative "Post.rb"
require_relative "Post_list.rb"

begin
  post1 = Post.new("Продажи", "Младший менеджер", 55000, true)
  post1.write_to_txt("input_data/post.txt")
  post1.write_to_yml("input_data/post.yml")

  puts "ЧТЕНИЕ ИЗ POST ИЗ TXT:\n\n"
  puts Post.txt("input_data/post.txt", true)
  puts "\n"

  puts "ЧТЕНИЕ ИЗ POST ИЗ YML:\n\n"
  puts Post.yml("input_data/post.yml", true)
  puts "\n"

  post2 = Post.new("Продажи", "Старший менеджер", 80000, true)
  post3 = Post.new("Бухгалтерия", "Бухгалтер", 40000, false)
  post4 = Post.new("Разработка", "Разработчик", 100000, true)

  posts = Post_list.new([post1, post2, post3, post4])

  posts.write_to_txt("input_data/post_list.txt")
  posts.write_to_yml("input_data/post_list.yml")

  puts "ЧТЕНИЕ ИЗ POST_LIST ИЗ TXT:\n\n"
  puts Post_list.txt('input_data/post_list.txt', true)
  puts "\n"

  puts "ЧТЕНИЕ ИЗ POST_LIST ИЗ YML:\n\n"
  puts Post_list.yml('input_data/post_list.yml', true)
  puts "\n"

  sales = Department.new("Продажи",
                         "+7 (996) 683-72-88",
                         ["Предлагать покупателям новые продукты",
                          "Проводить встречи с потенциальными клиентами",
                          "Устраивать рекламные акции"])

  sales.add_post(post1)
  sales.add_post(post2)

  sales.write_to_txt("input_data/department.txt")
  sales.write_to_yml("input_data/department.yml")

  puts "ЧТЕНИЕ ИЗ DEPARTMENT ИЗ TXT:\n\n"
  puts Department.txt("input_data/department.txt", true)
  puts "\n"

  puts "ЧТЕНИЕ ИЗ DEPARTMENT ИЗ YML:\n\n"
  puts Department.yml("input_data/department.yml", true)
  puts "\n"

  accounting = Department.new("Бухгалтерия",
                              "+7 (999) 529-23-57",
                              ["Подводить итоги в 19:00",
                               "Заносить данные о покупах"])

  development = Department.new("Разработка",
                               "+7 (992) 453-69-95",
                               ["Разрабатывать новые решение для улучшения производительности",
                                "Проводить тестирования новых решений"])

  accounting.add_post(post3)
  development.add_post(post4)

  departments = Department_list.new([sales, accounting, development])

  departments.write_to_txt("input_data/department_list.txt")
  departments.write_to_yml("input_data/department_list.yml")

  puts "ЧТЕНИЕ ИЗ DEPARTMENT_LIST ИЗ TXT:\n\n"
  puts Department_list.txt("input_data/department_list.txt", true)
  puts "\n"

  puts "ЧТЕНИЕ ИЗ DEPARTMENT_LIST ИЗ YML:\n\n"
  puts Department_list.yml("input_data/department_list.yml", true)
  puts "\n"

  departments.sort_by_name!
  puts "СОРТИРОВКА ПО ИМЕНИ ОТДЕЛА:\n\n"
  puts departments
  puts "\n"

  departments.sort_by_free!
  puts "СОРТИРОВКА ПО СВОБОДНЫМ ВАКАНСИЯМ:\n\n"
  puts departments
  puts "\n"
rescue ArgumentError, IOError => error
  puts "Error: " + error.message + "."
end