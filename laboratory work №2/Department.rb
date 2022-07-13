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

# ПОДЪЁМ ИСКЛЮЧЕНИЙ СНИЗУ-ВВЕРХ НУЖЕН ДЛЯ ТОГО,
# ЧТОБЫ БЫЛО ВИДНО ЧТО В ДАННОМ МЕТОДЕ МОЖЕТ ВОЗНИКНУТЬ ОШИБКА

require_relative "Post_list.rb"

class Department
  # поля: name, phone_number, duties, marking_duty_index, posts, marking_post_index
  attr_writer :name

  def initialize(name, phone_number, duties = [], posts = Post_list.new)
    @name = name.clone

    begin
      @phone_number = self.phone_number=(phone_number.clone)
    rescue ArgumentError => error
      raise error
    end

    @duties = []
    duties.each { |duty| add_duty(duty)}
    @marking_duty_index = -1

    @posts = posts.get_post_list
  end

  def get_department
    new_department = Department.new(@name, @phone_number, @duties, @posts)

    begin
      new_department.mark_duty(@marking_duty_index)
      new_department.mark_post(@posts.marking_post_index)
    rescue ArgumentError
      #ignored
    end

    return new_department
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

  def marking_duty_index
    return @marking_duty_index + 1
  end

  def marking_post_index
    return @posts.marking_post_index
  end

  def add_post(post)
    if post.department_name == @name
      begin
      @posts.add_post(post.get_post)
      rescue ArgumentError => error
        raise error
      end
    else
      raise ArgumentError, "The names of departments \"#{post.department_name}\" and \"#{name}\" don't match"
    end
  end

  def mark_post(post_index)
    begin
      @posts.mark_post(post_index)
    rescue ArgumentError => error
      raise error
    end
  end

  def delete_post
    begin
      @posts.delete_post
    rescue ArgumentError => error
      raise error
    end
  end

  def get_post_list
    return @posts.get_post_list
  end

  def get_free_post_list
    return @posts.get_free_post_list
  end

  def replace_post(post)
    if post.department_name == @name
      begin
        @posts.replace_post(post.get_post)
      rescue ArgumentError => error
        raise error
      end
    else
      raise ArgumentError, "The names of departments \"#{post.department_name}\" and \"#{name}\" don't match"
    end
  end

  def add_duty(duty_text)
    if @duties.include?(duty_text)
      raise ArgumentError, "This duty \"#{duty_text}\" already exists"
    else
      @duties.push(duty_text.clone)
    end
  end

  def is_index_correct?(index, list)
    return (0..list.size - 1).include?(index)
  end

  # индексация у пользователя начинается с 1
  def mark_duty(duty_index)
    duty_index -= 1

    if is_index_correct?(duty_index, @duties)
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

    if is_index_correct?(duty_index, @duties)
      @duties.delete_at(duty_index)
    else
      raise ArgumentError, "The duty index #{duty_index + 1} is incorrect"
    end
  end

  def get_marking_duty_text
    if is_index_correct?(@marking_duty_index, @duties)
      return @duties[@marking_duty_index].clone
    else
      raise ArgumentError, "The marking duty index #{@marking_duty_index + 1} is incorrect"
    end
  end

  def replace_marking_duty_text(duty_text)
    if @duties.include?(duty_text)
      raise ArgumentError, "This duty \"#{duty_text}\" already exists"
    elsif is_index_correct?(@marking_duty_index, @duties)
      @duties[@marking_duty_index] = duty_text.clone
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

  def to_s
    result = "Отдел: #{@name}\n" + "Номер: #{@phone_number}\n" +
      ((get_duties_to_s == "")? "": "\n" + get_duties_to_s) + "\n" + @posts.to_s

    return result
  end

  private :is_index_correct?, :get_duties_to_s
end

begin
  sales = Department.new("Продажи", "+7 (996) 683-72-88")

  sales.add_duty("Предлагать покупателям новые продукты")
  sales.add_duty("Проводить встречи с потенциальными клиентами")
  sales.add_duty("Устраивать рекламные акции")

  post1 = Post.new("Продажи", "Младший менеджер", 45000, false)
  post2 = Post.new("Продажи", "Старший менеджер", 60000, true)
  post3 = Post.new("Продажи", "Директор по развитию", 80000, false)
  post4 = Post.new("Продажи", "Руководитель отдела продаж", 100000, true)

  sales.add_post(post1)
  sales.add_post(post2)
  sales.add_post(post3)
  sales.add_post(post4)

  post1.post_name = ""

  sales.mark_duty(1)
  a = sales.get_marking_duty_text
  a[0] = "r"
  # sales.delete_post
  #
  # sales.mark_post(3)
  # sales.replace_post(post1)

  # puts sales.get_all_posts
  sales.print_duties
rescue ArgumentError => error
  puts "Error: " + error.message + "."
end
