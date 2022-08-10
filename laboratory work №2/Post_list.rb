require_relative "Post.rb"

class Post_list
  # поля: post_list, marking_post_index

  def initialize(post_list = [])
    @post_list = []
    @marking_post_index = -1

    begin
      post_list.each { |post| add_post(post)}
    rescue ArgumentError => error
      raise error
    end
  end

  def Post_list.txt(file_name_or_content, is_file_name)
    content = file_name_or_content

    if is_file_name
      begin
        File.open(file_name_or_content, "r:UTF-8") { |file| content = file.read }
      rescue
        raise IOError, "The file \"#{file_name_or_content}\" can't be opened"
      end
    end

    post_list = []

    begin
      content.split("\n\n").each { |post| post_list.push(Post.txt(post, false))}
    rescue
      raise IOError, "Incorrect Post_list TXT-format"
    end

    return new(post_list)
  end

  def Post_list.yml(file_name_or_content, is_file_name)
    data = file_name_or_content

    if is_file_name
      begin
        data = YAML.load(File.open(file_name_or_content))
      rescue IOError
        raise IOError, "The file \"#{file_name_or_content}\" can't be opened"
      end
    end

    post_list = []
    data.each do |post|
      begin
        post_list.push(Post.yml(post, false))
      rescue IOError
        raise IOError, "Incorrect Post_list YML-format"
      end
    end

    return new(post_list)
  end

  # 'клонирование' объекта
  def get_post_list
    return Post_list.new(@post_list)
  end

  def get_free_post_list
    return Post_list.new(
      @post_list.select { |post| post.is_free}.map {|post| post.get_post})
  end

  def get_free_posts_size
    return @post_list.count { |post| post.is_free}
  end

  def marking_post_index
    return @marking_post_index + 1
  end

  def size
    return @post_list.size
  end

  def empty?
    return size == 0
  end

  def sort!
    @post_list.sort_by! { |post| post.department_name }
  end

  def to_s
    s = "Вакансии:\n\n"
    @post_list.each_index {|i|
      s += "№#{i + 1} #{@post_list[i]}\n"
    }
    return s.rstrip
  end

  def short_to_s
    return "Свободные вакансии: #{get_free_posts_size}"
  end

  def add_post(new_post)
    @post_list.each { |post|
      if (post.department_name == new_post.department_name) and
        (post.post_name == new_post.post_name)
        raise ArgumentError, "This post \"#{new_post.post_name}\" in the department \"#{new_post.department_name}\" already exists"
      end
    }
    @post_list.push(new_post.get_post)
  end

  def is_index_correct?(index, list)
    return (0..list.size - 1).include?(index)
  end

  # индексация у пользователя начинается с 1
  def mark_post(post_index)
    post_index -= 1
    if is_index_correct?(post_index, @post_list)
      @marking_post_index = post_index
    else
      raise ArgumentError, "The post index #{post_index + 1} is incorrect"
    end
  end

  def replace_post(new_post)
    @post_list.each { |post|
      if (post.department_name == new_post.department_name) and (post.post_name == new_post.post_name)
        raise ArgumentError, "This post \"#{new_post.post_name}\" in the department #{new_post.department_name} already exists\n"
      end
    }

    if is_index_correct?(@marking_post_index, @post_list)
      @post_list[@marking_post_index] = new_post.get_post
    else
      raise ArgumentError, "The marking post index #{@marking_post_index + 1} is incorrect"
    end
  end

  def get_marking_post
    if is_index_correct?(@marking_post_index, @post_list)
      return @post_list[@marking_post_index].get_post
    else
      raise ArgumentError, "The marking post index #{@marking_post_index + 1} is incorrect"
    end
  end

  def delete_post
    if is_index_correct?(@marking_post_index, @post_list)
      @post_list.delete_at(@marking_post_index)
      @marking_post_index = -1
    else
      raise ArgumentError, "The marking department index #{@marking_post_index + 1} is incorrect"
    end
  end

  def post_list_to_txt
    output = ""
    @post_list.each { |post| output += post.post_to_txt + "\n\n" }

    return output.rstrip
  end

  def write_to_txt(file_name)
    File.open(file_name, "w:UTF-8") { |file| file.print(post_list_to_txt) }
  end

  def write_to_yml(file_name)
    File.open(file_name, "w:UTF-8") do |file|
      YAML.dump(to_hash, file)
    end
  end

  def to_hash
    return @post_list.map { |post| post.to_hash }
  end

  private :is_index_correct?
end
