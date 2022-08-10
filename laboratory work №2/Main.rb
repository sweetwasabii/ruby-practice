require_relative "Department.rb"
require_relative "Department_list.rb"

require_relative "Post.rb"
require_relative "Post_list.rb"

begin
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

  post1 = Post.new("Продажи", "Младший менеджер", 55000, true)
  post2 = Post.new("Продажи", "Старший менеджер", 80000, true)
  post3 = Post.new("Бухгалтерия", "Бухгалтер", 40000, false)
  post4 = Post.new("Разработка", "Разработчик", 100000, true)

  sales.add_post(post1)
  sales.add_post(post2)
  accounting.add_post(post3)
  development.add_post(post4)

  departments = Department_list.new([sales, accounting, development])

  departments.sort_by_free!

  puts departments
  # sales = Department.new("Продажи",
  #                        "+7 (996) 683-72-88",
  #                        ["Предлагать покупателям новые продукты",
  #                         "Проводить встречи с потенциальными клиентами",
  #                         "Устраивать рекламные акции"])
  #
  # accounting = Department.new("Бухгалтерия",
  #                             "+7 (999) 529-23-57",
  #                             ["Подводить итоги в 19:00",
  #                              "Заносить данные о покупах"])
  #
  # development = Department.new("Разработка",
  #                              "+7 (992) 453-69-95",
  #                              ["Разрабатывать новые решение для улучшения производительности",
  #                               "Проводить тестирования новых решений"])
  #
  # post1 = Post.new("Продажи", "Младший менеджер", 55000, false)
  # post2 = Post.new("Продажи", "Старший менеджер", 80000, true)
  # post3 = Post.new("Бухгалтерия", "Бухгалтер", 40000, false)
  # post4 = Post.new("Разработка", "Разработчик", 100000, false)
  #
  # posts = Post_list.new([post1, post2, post3, post4])
  #
  # sales.add_post(post1)
  # sales.add_post(post2)
  # accounting.add_post(post3)
  # development.add_post(post4)
  #
  # departments = Department_list.new
  # departments.add_department(sales)
  # departments.add_department(accounting)
  # departments.add_department(development)
  #
  # sales.write_to_txt("input_data/department.txt")
  # departments.write_to_txt("input_data/department_list.txt")
  #
  # post1.write_to_txt("input_data/post.txt")
  # posts.write_to_txt("input_data/post_list.txt")
  #
  # post1.write_to_YAML("input_data/post.yml")
  # # posts.write_to_YAML("input_data/post_list.yml")
  #
  # sales.write_to_YAML("input_data/department.yml")
  # departments.write_to_YAML("input_data/department_list.yml")

  # File.open("input_data/post.yml", "r:UTF-8") do |file|
  #   data = YAML.load(file.read)
  #   puts data
  # end

  # Post.yaml("input_data/post.yml")

  # b = Post.txt("input_data/post.txt", true)
  # b.write_to_txt("output_data/post.txt")
  # Post.yaml("input_data/post.yml") # .write_to_YAML("output_data/post.yml")
  # puts Post.txt("input_data/post.txt", true)
  # puts Post_list.txt("input_data/post_list.txt", true)
  # puts Department.txt("input_data/department.txt", true)
  # puts Department_list.txt("input_data/department_list.txt", true)

  data = Post.yaml('input_data/post.yml')

rescue ArgumentError, IOError => error
  puts "Error: " + error.message + "."
end