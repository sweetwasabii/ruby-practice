=begin

1.1 Создать класс Department с полями объекта название, контактный телефон.
Написать конструктор, геттеры и сеттеры. Избежать дублирования кода.
Рассмотреть способы реализации геттеров и сеттеров с помощью символов.

1.2 Создать несколько объектов, вывести информацию о них на экран.
Продумать корректный способ вывода информации о текущем состоянии объекта на экран.

1.3 Создать поле выполнение обязанностей.

Реализовать методы:

добавить обязанность
выделить обязанность
удалить обязанность
получить текст выделенной обязанности
заменить текст выделенной обязанности
вывести список обязанностей на экран

Объяснить, почему с точки зрения основных принципов ООП нежелательно получать доступ к массиву целиком.
Продумать, каким должен быть в этом случае конструктор и внести изменения.

1.4 Создать объект класса Department.

добавить
изменить
удалить несколько обязанностей

Отследить корректность выполнения методов.

Внести коррективы в отображение объекта на экране так,
чтобы была возможность отслеживать состояние поля, содержащего обязанности.

1.5 Добавить метод КЛАССА, проверяющий, является ли некоторая строка телефонным номером.
Модифицировать класс так, чтобы в произвольный момент времени не мог существовать объект
с непозволительной строкой в поле номер телефона. Протестировать полученный класс.

5.1 В класс Department добавьте поле Post_list.
Обновите конструктор.

5.2 Напишите методы:

добавить должность,
выбрать должность,
удалить должность,
изменить должность.

5.3 Напишите метод, который позволит получить все вакантные должности этого отдела.

5.4 Продумайте метод получения всех должностей данного отдела, обоснуйте выбор.

5.5 Перепишите методы сериализации/десериализации всех описанных классов так,
чтобы метод класса Department_list вызывал соответствующий метод класса Department,
который вызывал метод класса Post_list, который вызывает соответствующий метод класса Post.

=end

# require_relative "Post_list.rb"

class Department
  # поля: name, phone_number, duties, marking_duty_index, posts
  attr_reader :marking_duty_index
  attr_writer :name

  def initialize(name, phone_number) #, posts)
    @name = self.name=(name)
    @phone_number = self.phone_number=(phone_number)
    @duties = []
    @marking_duty_index = -1

    # @posts = Post_list.new
    # posts.each { |post| @posts.add_note(post) }
  end

  def name
    return @name.clone
  end

  def phone_number
    return @phone_number.clone
  end

  # формат номера: +7 (918) 648-07-50
  def phone_number=(new_phone_number)
    if new_phone_number.size == 18 and
      (new_phone_number =~ /\+7\s\(\d{3}\)\s\d{3}-\d{2}-\d{2}/) == 0
      @phone_number = new_phone_number
    else
      raise ArgumentError, "The phone number #{new_phone_number} is incorrect"
    end
  end

  def add_duty(duty_text)
    if @duties.include?(duty_text)
      raise ArgumentError, "This duty \"#{duty_text}\" already exists"
    else
      @duties.push(duty_text)
    end
  end

  def is_index_correct(index, list)
    return (0..list.size - 1).include?(index)
  end

  # индексация у пользователя начинается с 1
  def mark_duty(duty_index)
    duty_index -= 1

    if is_index_correct(duty_index, @duties)
      @marking_duty_index = duty_index
    else
      raise ArgumentError, "The duty index #{duty_index + 1} is incorrect"
    end
  end

  def delete_duty(duty_index)
    duty_index -= 1

    if duty_index == @marking_duty_index
      @marking_duty_index = -1
    end

    if is_index_correct(duty_index, @duties)
      @duties.delete_at(duty_index)
    else
      raise ArgumentError, "The duty index #{duty_index + 1} is incorrect"
    end
  end

  def get_marking_duty_text
    if is_index_correct(@marking_duty_index, @duties)
      return @duties[@marking_duty_index]
    else
      raise ArgumentError, "The marking duty index #{@marking_duty_index + 1} is incorrect"
    end
  end

  def replace_marking_duty_text(duty_text)
    if @duties.include?(duty_text)
      raise ArgumentError, "This duty \"#{duty_text}\" already exists"
    elsif is_index_correct(@marking_duty_index, @duties)
      @duties[@marking_duty_index] = duty_text
    else
      raise ArgumentError, "The marking duty index #{@marking_duty_index + 1} is incorrect"
    end
  end

  def get_duties_to_s
    text = ""
    unless @duties.empty?
      text += "Обязанности:\n\n"
      @duties.each_index { |index|
        text += "#{index + 1}. #{@duties[index]};\n"
      }
    end
    return text
  end

  def print_duties
    puts get_duties_to_s
  end

  # def posts
  #   result = {}
  #   @posts.each { |post| result[post.name] = salary}
  #
  #   return result
  # end
  #
  #
  #
  # def add_post(post)
  #   @posts.add_note(post)
  # end
  #
  # def delete_post
  #   if is_index_correct(@posts.chosen_note_index, @posts)
  #     @posts.delete_note
  #   end
  # end
  #
  # def choose_post(post_index)
  #   if is_index_correct(post_index - 1, @posts)
  #     @posts.choose_note(post_index)
  #   end
  # end
  #
  # def change_post(post)
  #   if is_index_correct(@posts.chosen_note_index, @posts)
  #     @posts.change_note(post)
  #   end
  # end
  #
  # def get_free_posts
  #   free = []
  #   posts.each { |post|
  #     if post.is_free
  #       free.push(post)
  #     end
  #   }
  #
  #   return free
  # end

  def to_s
    result = "Отдел: #{@name}\n" + "Номер: #{@phone_number}\n" +
      ((get_duties_to_s == "")? "": "\n" + get_duties_to_s) + "\n"

    # result += "Должности:\n\n"
    # @posts.each { |post|
    #   result += "Название: #{post.name}\n" +
    #     "Зарплата: #{post.salary}\n" +
    #     "Вакантно: #{((post.is_free)? "Да": "Нет")}\n\n"
    # }

    return result
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
  accounting.delete_duty(1)

  development = Department.new("Разработка", "+7 (992) 453-69-95")
  development.add_duty("Разрабатывать новые решение для улучшения производительности")
  development.add_duty("Проводить тестирования новых решений")
  development.mark_duty(1)
  development.replace_marking_duty_text("Разрабатывать новые решение для улучшения эффективности")

  # puts sales.to_s + "\n" + accounting.to_s + "\n" + development.to_s
rescue ArgumentError => error
  puts "Error: " + error.message + "."
end
