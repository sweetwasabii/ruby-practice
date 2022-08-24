require "yaml"
require_relative "Department.rb"

class Department_list
  # поля: department_list, marking_department_index
  attr_reader :marking_department_index

  def initialize(department_list = [])
    @department_list = []
    @marking_department_index = -1

    begin
      department_list.each { |department| add_department(department)}
    rescue ArgumentError => error
      raise error
    end
  end

  def Department_list.yml(file_name_or_content, is_file_name)
    data = file_name_or_content

    if is_file_name
      begin
        data = YAML.load(File.open(file_name_or_content))
      rescue
        raise IOError, "The file \"#{file_name_or_content}\" can't be opened"
      end
    end

    department_list = []
    data.each do |department|
      begin
        department_list.push(Department.yml(department, false))
      rescue
        raise IOError, "Incorrect Post_list YML-format"
      end
    end

    return new(department_list)
  end

  # 'клонирование' объекта
  def get_department_list
    return Department_list.new(@department_list)
  end

  def sort_by_name!
    @department_list.sort_by! { |department| department.name }
  end

  def sort_by_free!
    @department_list.sort_by! { |department| department.get_free_posts_size }.reverse!
  end

  def to_s
    s = ""
    @department_list.each_index {|i|
      s += "№#{i + 1} #{@department_list[i].short_to_s}\n\n"
    }
    return s.rstrip
  end

  def get_department_names
    return @department_list.map { |department| department.name}
  end

  def add_department(department)
    if get_department_names.include?(department.name)
      raise ArgumentError, "This department \"#{department.name}\" already exists"
    else
      @department_list.push(department.get_department)
    end
  end

  def is_index_correct?(index, list)
    return (0..list.size - 1).include?(index)
  end

  # индексация у пользователя начинается с 1
  def mark_department(department_index)
    department_index -= 1
    if is_index_correct?(department_index, @department_list)
      @marking_department_index = department_index
    else
      raise ArgumentError, "The department index #{department_index + 1} is incorrect"
    end
  end

  def replace_department(new_department)
    if get_department_names.include?(new_department.name)
      raise ArgumentError, "This department \"#{new_department.name}\" already exists"
    elsif is_index_correct?(@marking_department_index, @department_list)
      @department_list[@marking_department_index] = new_department.get_department
    else
      raise ArgumentError, "The marking department index #{@marking_department_index + 1} is incorrect"
    end
  end

  def get_marking_department
    if is_index_correct?(@marking_department_index, @department_list)
      return @department_list[@marking_department_index].get_department
    else
      raise ArgumentError, "The marking department index #{@marking_department_index + 1} is incorrect"
    end
  end

  def delete_department
    if is_index_correct?(@marking_department_index, @department_list)
      @department_list.delete_at(@marking_department_index)
      @marking_department_index = -1
    else
      raise ArgumentError, "The marking department index #{@marking_department_index + 1} is incorrect"
    end
  end

  def department_list_to_txt
    output = ""
    @department_list.each { |department| output += department.department_to_txt + "\n\n\n"}

    return output.rstrip
  end

  def write_to_yml(file_name)
    File.open(file_name, "w:UTF-8") do |file|
      YAML.dump(to_hash, file)
    end
  end

  def to_hash
    department_list_hash = []
    @department_list.each { |department| department_list_hash.push(department.to_hash) }

    return department_list_hash
  end

  private :is_index_correct?, :get_department_names
end