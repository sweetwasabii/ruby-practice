require_relative "Department.rb"
require_relative "Department_list.rb"

require_relative "Post.rb"
require_relative "Post_list.rb"

begin
=begin
  # проверка клаасса Post
  post1 = Post.new("Продажи", "Младший менеджер", 55000, false)
  # post1.write_to_txt("input_data/post.txt")
  post1.write_to_yml("input_data/post.yml")

  # post1_1 = Post.txt("input_data/post.txt", true)
  post1_2 = Post.yml("input_data/post.yml", true)

  # puts post1_1
  puts post1_2

  # post1_3 = Post.txt("input_data/posti.txt", true)
  # post1_4 = Post.yaml("input_data/posti.yml")
=end

=begin
  # проверка класса Post_list
  post1 = Post.new("Продажи", "Младший менеджер", 55000, false)
  post2 = Post.new("Продажи", "Старший менеджер", 80000, true)
  post3 = Post.new("Бухгалтерия", "Бухгалтер", 40000, false)
  post4 = Post.new("Разработка", "Разработчик", 100000, false)

  posts = Post_list.new([post1, post2, post3, post4])

  # posts.write_to_txt("input_data/post_list.txt")
  # posts.write_to_yml("input_data/post_list.yml")

  post_txt = Post_list.txt('input_data/post_list.txt', true)
  post_yml = Post_list.yml('input_data/post_list.yml', true)

  puts post_txt
  puts post_yml
=end

=begin
  # проверка класса Department
  post1 = Post.new("Продажи", "Младший менеджер", 55000, false)
  post2 = Post.new("Продажи", "Старший менеджер", 80000, true)
  posts = Post_list.new([post1, post2])

  sales = Department.new("Продажи",
                         "+7 (996) 683-72-88",
                         ["Предлагать покупателям новые продукты",
                          "Проводить встречи с потенциальными клиентами",
                          "Устраивать рекламные акции"],
                         posts)

  # sales.write_to_txt("input_data/department.txt")
  # sales.write_to_yml("input_data/department.yml")

  sales_txt = Department.txt("input_data/department.txt", true)
  sales_yml = Department.yml("input_data/department.yml", true)

  puts sales_txt
  puts sales_yml
=end

=begin
  # проверка класса Department_list
  sales = Department.new("Продажи",
                         "+7 (996) 683-72-88",
                         ["Предлагать покупателям новые продукты",
                          "Проводить встречи с потенциальными клиентами",
                          "Устраивать рекламные акции"])

  accounting = Department.new("Бухгалтерия",
                              "+7 (999) 529-23-57",
                              ["Подводить итоги в 19:00",
                               "Заносить данные о покупах"])

  development = Department.new("Разработка",
                               "+7 (992) 453-69-95",
                               ["Разрабатывать новые решение для улучшения производительности",
                                "Проводить тестирования новых решений"])

  post1 = Post.new("Продажи", "Младший менеджер", 55000, false)
  post2 = Post.new("Продажи", "Старший менеджер", 80000, true)
  post3 = Post.new("Бухгалтерия", "Бухгалтер", 40000, false)
  post4 = Post.new("Разработка", "Разработчик", 100000, false)

  sales.add_post(post1)
  sales.add_post(post2)
  accounting.add_post(post3)
  development.add_post(post4)

  departments = Department_list.new([sales, accounting, development])

  departments.write_to_txt("input_data/department_list.txt")
  departments.write_to_yml("input_data/department_list.yml")

  departments_txt = Department_list.txt("input_data/department_list.txt", true)
  departments_yml = Department_list.yml("input_data/department_list.yml", true)

  puts departments_txt
  puts departments_yml
=end
end