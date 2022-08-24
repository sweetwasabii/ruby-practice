require_relative "Salary.rb"
require_relative "Ruble_salary.rb"
require_relative "Percent_salary.rb"
require_relative "Ruble_percent_salary.rb"

require_relative "Department.rb"
require_relative "Department_list.rb"

require_relative "Post.rb"
require_relative "Post_list.rb"

salary = Premium_fined_ruble_salary.new(1000, 1200, 300, 400).to_hash
post1 = Post.new("Продажи", "Младший менеджер", salary, true)

post1.write_to_yml("input_data/post.yml")
post2 = Post.yml("input_data/post.yml", true)

puts post1
puts post2
post2.write_to_yml("input_data/post.yml")
post2.department_name = "кто-то"

posts = Post_list.new([post1, post2])


