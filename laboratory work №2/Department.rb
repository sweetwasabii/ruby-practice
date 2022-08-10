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

2.1 Продумайте структуру текстового файла, в котором будут
храниться объекты класса Department. Напишите такой файл.

2.2 Напишите метод, который читает read_from_txt,
который читает несколько отделов из текстового файла и возвращает массив объектов класса Department.

2.3 Написать метод, который выводит массив объектов класса Department на экран.

2.4 Написать метод write_to_txt, который записывает массив объектов класса Department в файл txt.

2.5 Прочитать массив объектов, вывести на экран, добавить еще один отдел,
вывести результат на экран, записать измененный массив в тот же файл.

2.6 Написать метод write_to_YAML, который записывает массив объектов класса Department в файл YAML.

2.7 Напишите метод, который читает read_from_YAML,
который читает несколько отделов из YAML файла и возвращает массив объектов класса Department.

2.8 Прочитать массив объектов, вывести на экран, добавить еще один отдел,
вывести результат на экран, записать измененный массив в тот же файл.

5.1 В класс Department добавьте поле Post_list. Обновите конструктор.

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

# CLONE, NEW И ПРОЧЕЕ НУЖНО ДЛЯ ТОГО,
# ЧТОБЫ НЕ БЫЛО ДОСТУПА К ПЕРЕМЕННЫМ КЛАССА ИЗВНЕ

require_relative "Post_list.rb"

class Department
  # поля: name, phone_number, duties, marking_duty_index, posts, marking_post_index
  attr_writer :name

  def initialize(name, phone_number, duties = [], posts = Post_list.new)
    @name = name.clone

    @duties = []
    @marking_duty_index = -1

    begin
      @phone_number = self.phone_number=(phone_number.clone)
      duties.each { |duty| add_duty(duty)}
      @posts = posts.get_post_list
    rescue ArgumentError => error
      raise error
    end
  end

  def Department.txt(file_name_or_content, is_file_name)
    content = file_name_or_content

    if is_file_name
      begin
        File.open(file_name_or_content, "r:UTF-8") { |file| content = file.read }
      rescue
        raise IOError, "The file \"#{file_name_or_content}\" can't be opened"
      end
    end

    department_info = content.split("\n\n")

    begin
      next_index = 0
      next_info = department_info[next_index].split("\n")

      name = next_info[0]
      phone_number = next_info[1]

      duties = []
      posts = ""

      next_index = 1
      if next_index < department_info.size
        next_info = department_info[next_index].split("\n")

        if next_info[0] != name
          duties = next_info
          next_index += 1
        end

        if next_index < department_info.size
          next_info = department_info.slice(next_index..department_info.size - 1)
          next_info.each { |post| posts += post + "\n\n"}
          posts.rstrip
        end
      end
    rescue
      raise IOError, "Incorrect Department TXT-format"
    end

    new(name, phone_number, duties, Post_list.txt(posts, false))
  end

  def Department.yml(file_name_or_content, is_file_name)
    data = file_name_or_content

    if is_file_name
      begin
        data = YAML.load(File.open(file_name_or_content))
      rescue
        raise IOError, "The file \"#{file_name_or_content}\" can't be opened"
      end
    end

    begin
      name = data[:name]
      phone_number = data[:phone_number]
      duties = data[:duties]
      posts = Post_list.yml(data[:posts], false)
    rescue
      raise IOError, "Incorrect Department YML-format"
    end

    return new(name, phone_number, duties, posts)
  end

  def get_department
    return Department.new(@name, @phone_number, @duties, @posts)
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

  def to_s
    result = "Отдел: #{@name}\n" + "Номер: #{@phone_number}\n" +
      (@duties.empty? ? "": "\n" + get_duties_to_s + "\n") +
      (@posts.empty? ? "": "\n" + @posts.to_s)

    return result.rstrip
  end

  def get_post_list
    return @posts.get_post_list
  end

  def get_free_post_list
    return @posts.get_free_post_list
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

  def get_duties
    return @duties.map { |duty| duty.clone }
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
    return text.rstrip
  end

  def print_duties
    puts get_duties_to_s
  end

  def department_to_txt
    output = @name + "\n" + @phone_number + "\n\n"

    @duties.each { |duty| output += duty + "\n" }
    unless @duties.empty?
      output += "\n"
    end

    output += @posts.post_list_to_txt

    return output.rstrip
  end

  def write_to_txt(file_name)
    File.open(file_name, "w:UTF-8") { |file| file.print(department_to_txt) }
  end

  def write_to_yml(file_name)
    File.open(file_name, "w:UTF-8") do |file|
      YAML.dump(to_hash, file)
    end
  end

  def to_hash
    return {
      :name => @name,
      :phone_number => @phone_number,
      :duties => @duties,
      :posts => @posts.to_hash
    }
  end

  private :is_index_correct?, :get_duties_to_s
end