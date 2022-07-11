# Изменены классы, предыдущие файлы с заданиями могут не работать

# 5.5 Протестируйте написанные методы, покажите все построенные
# возможности, расскажите, какие возможности теперь доступны при работе с Вашими классами.

require_relative "Department.rb"
require_relative "Department_list.rb"
require_relative "Post.rb"
require_relative "Post_list.rb"

post1 = Post.new("Продажи", "Младший менеджер", 55000, false)
post2 = Post.new("Продажи", "Старший менеджер", 80000, true)
posts = Post_list.new(post1, post2)

duties = ["Предлагать покупателям новые продукты",
          "Проводить встречи с потенциальными клиентами"]

sales = Department.new("Продажи", "+7 (996) 683-72-88", duties, posts)

post3 = Post.new("Продажи", "Специалист по связям с общественностью", 100000, true)
sales.add_post(post3)

sales.choose_post(3)

post4 = Post.new("Продажи", "PR-менеджер", 110000, true)
sales.change_post(post4)

# puts sales.to_s
puts sales.get_posts.to_s
