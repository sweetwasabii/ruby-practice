class Post
  # поля: department_name, post_name, salary, is_free
  attr_accessor :salary, :is_free
  attr_writer :department_name, :post_name

  def initialize(department_name, post_name, salary, is_free)
    @department_name, @post_name = department_name.clone, post_name.clone
    @salary, @is_free = salary, is_free
  end

  def Post.txt(file_name_or_content, is_file_name)
    content = file_name_or_content

    if is_file_name
      begin
        File.open(file_name_or_content, "r:UTF-8") { |file| content = file.read }
      rescue
        raise IOError, "The file \"#{file_name_or_content}\" can't be opened"
      end
    end

    post_info = content.split("\n")
    if post_info.size != 4
      raise IOError, "Incorrect Post TXT-format"
    end

    begin
      department_name = post_info[0]
      post_name = post_info[1]
      salary = post_info[2]
      is_free = (post_info[3] == "Да" ? true: false)
    rescue
      raise IOError, "Incorrect Post TXT-format"
    end

    return new(department_name, post_name, salary, is_free)
  end

  def Post.yml(file_name_or_content, is_file_name)
    data = file_name_or_content

    if is_file_name
      begin
        data = YAML.load(File.open(file_name_or_content))
      rescue
        raise IOError, "The file \"#{file_name_or_content}\" can't be opened"
      end
    end

    begin
      department_name = data[:department_name]
      post_name = data[:post_name]
      salary = data[:salary]
      is_free = data[:is_free]
    rescue
      raise IOError, "Incorrect Post YML-format"
    end

    return new(department_name, post_name, salary, is_free)
  end

  # 'клонирование' объекта
  def get_post
    return Post.new(@department_name, @post_name, @salary, @is_free)
  end

  def department_name
    return @department_name.clone
  end

  def post_name
    return @post_name.clone
  end

  def to_s
    return "Отдел: #{@department_name}\n"+ "Должность: #{@post_name}\n" +
      "Зарплата: #{@salary}\n" + "Вакантно: " + ((@is_free == true)? "Да": "Нет") + "\n"
  end

  def post_to_txt
    return department_name + "\n" + post_name + "\n" +
      salary.to_s + "\n" + (is_free == true ? "Да": "Нет")
  end

  def write_to_txt(file_name)
    File.open(file_name, "w:UTF-8") { |file| file.print(post_to_txt) }
  end

  def write_to_yml(file_name)
    File.open(file_name, "w:UTF-8") do |file|
      YAML.dump(to_hash, file)
    end
  end

  def to_hash
    return {
      :department_name => @department_name,
      :post_name => @post_name,
      :salary => @salary,
      :is_free => @is_free
    }
  end
end
