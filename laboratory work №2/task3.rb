require_relative "Department.rb"
require_relative "Department_list.rb"

departments = Department_list.yaml("input_yaml.yml")
puts departments.to_s

# departments = Department_list.txt("input_departments.txt")
# puts departments.to_s

=begin
sales = Department.new("Продажи", "+7 (996) 683-72-88",
                       "Предлагать покупателям новые продукты",
                       "Проводить встречи с потенциальными клиентами")
accounting = Department.new("Бухгалтерия", "+7 (999) 529-23-57",
                            "Подводить итоги в 19:00",
                            "Заносить данные о покупах")
development = Department.new("Разработка", "+7 (992) 453-69-95",
                             "Разрабатывать новые решение для улучшения производительности",
                             "Проводить тестирования новых решений")

departments = Department_list.new(sales, accounting, development)
puts departments.to_s
=end

departments.add_note(Department.new("Аналитика", "+7 (918) 648-07-50", "Проводить опросы"))
puts departments.to_s

departments.choose_note(1)
puts "Выбранный отдел:\n\n" + departments.get_note.to_s + "\n"

department = Department.new("Связи с общественностью","+7 (999) 845-22-10", "Готовить рекламные кампании")
departments.change_note(department)
puts "Выбранный отдел:\n\n" + departments.get_note.to_s + "\n"

departments.delete_note
puts departments.to_s
