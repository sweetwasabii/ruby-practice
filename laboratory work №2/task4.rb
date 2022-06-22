require_relative "Department.rb"
require_relative "Department_list.rb"
require_relative "Post.rb"

sales = Department.new("Продажи", "+7 (996) 683-72-88",
                       "Предлагать покупателям новые продукты",
                       "Проводить встречи с потенциальными клиентами")
accounting = Department.new("Бухгалтерия", "+7 (999) 529-23-57",
                            "Подводить итоги в 19:00",
                            "Заносить данные о покупах")
development = Department.new("Разработка", "+7 (992) 453-69-95",
                             "Разрабатывать новые решение для улучшения производительности",
                             "Проводить тестирования новых решений")

post1 = Post.new(sales, "Младший менеджер", 55000, false)
post2 = Post.new(sales, "Старший менеджер", 80000, true)
post3 = Post.new(accounting, "Бухгалтер", 40000, false)
post4 = Post.new(development, "Разработчик", 100000, false)

posts = [post1, post2, post3, post4]
posts.each { |post| puts post.to_s + "\n"}
