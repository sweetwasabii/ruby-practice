require_relative 'Salary.rb'
require_relative 'Ruble_salary.rb'
require_relative 'Percent_salary.rb'
require_relative 'Ruble_percent_salary.rb'

class Post
  # поля: department_name, post_name, salary, is_free
  attr_accessor :is_free
  attr_writer :department_name, :post_name

  def initialize(department_name, post_name, salary, is_free)
    @department_name, @post_name = department_name.clone, post_name.clone
    @is_free = is_free

    self.salary=(salary)
  end

  def salary
    return @salary.get_salary
  end

  def salary=(salary_hash)
    salary_class = salary_hash[:salary_class]
    salary_hash.delete(:salary_class)

    salary_args = salary_hash.values

    @salary = Object.const_get(salary_class).new(*salary_args)
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
    return Post.new(@department_name, @post_name, @salary.to_hash, @is_free)
  end

  def department_name
    return @department_name.clone
  end

  def post_name
    return @post_name.clone
  end

  def to_s
    return "Отдел: #{@department_name}\n"+ "Должность: #{@post_name}\n" +
      "Зарплата: #{self.salary}\n" + "Вакантно: " + ((@is_free == true)? "Да": "Нет") + "\n"
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
      :salary => @salary.to_hash,
      :is_free => @is_free
    }
  end
end
