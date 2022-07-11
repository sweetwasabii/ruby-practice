# 4.2 По аналогии с классом Department_list напишите класс Post_list.

require_relative "Post.rb"

class Post_list
  # поля: post_list, marking_department_index
  attr_reader :marking_post_index

  def initialize
    @post_list = []
    @marking_post_index = -1
  end

  # def Post_list.txt(file_name)
  #   file = File.new(file_name, "r:UTF-8")
  #   content = file.read
  #
  #   posts = []
  #   content.strip.split("\n\n").each { |result|
  #     post = result.split("\n")
  #     department = post[0]
  #     name = post[1]
  #     salary = post[2]
  #     is_free = (post[3] == "Да")? true: false
  #
  #     posts.push(Post.new(department, name, salary, is_free))
  #   }
  #
  #   file.close
  #   new(*posts)
  # end
  #
  # def Post_list.yaml(file_name)
  #   file = File.new(file_name, "r:UTF-8")
  #   content = file.read
  #
  #   file.close
  #   new(*YAML.load(content))
  # end

  def add_post(new_post)
    @post_list.each { |post|
      if (post.department_name == new_post.department_name) and
        (post.post_name == new_post.post_name)
        raise ArgumentError, "This post \"#{new_post.post_name}\" in the department \"#{new_post.department_name}\" already exists"
      end
    }
    @post_list.push(new_post)
  end

  def is_index_correct(index, list)
    return (0..list.size - 1).include?(index)
  end

  # индексация у пользователя начинается с 1
  def mark_post(post_index)
    post_index -= 1
    if is_index_correct(post_index, @post_list)
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

    if is_index_correct(@marking_post_index, @post_list)
      @post_list[@marking_post_index] = new_post
    else
      raise ArgumentError, "The marking post index #{@marking_post_index + 1} is incorrect"
    end
  end

  def get_post
    if is_index_correct(@marking_post_index, @post_list)
      return @post_list[@marking_post_index]
    else
      raise ArgumentError, "The marking post index #{@marking_post_index + 1} is incorrect"
    end
  end

  def delete_post
    if is_index_correct(@marking_post_index, @post_list)
      @post_list.delete_at(@marking_post_index)
      @marking_post_index = -1
    else
      raise ArgumentError, "The marking department index #{@marking_post_index + 1} is incorrect"
    end
  end

  # def write_to_YAML(file_name)
  #   file = File.new(file_name, "w:UTF-8")
  #   file.print(@notes_list.to_yaml)
  #
  #   file.close
  # end
  #
  # def write_to_txt(file_name)
  #   file = File.new(file_name, "w:UTF-8")
  #   @notes_list.each { |post|
  #     output = post.department + "\n" +
  #       post.name + "\n" +
  #       post.salary + "\n" +
  #       ((post.is_free)? "Дa": "Нет") + "\n"
  #     file.print("#{output}\n")
  #   }
  #
  #   file.close
  # end

  def sort
    @post_list.sort! { |post1, post2| post1.department_name <=> post2.department_name }
  end

  def to_s
    s = ""
    @post_list.each_index {|i|
      s += "№#{i + 1} #{@post_list[i]}\n"
    }
    return s
  end
end

begin
  post1 = Post.new("Продажи", "Младший менеджер", 55000, false)
  post2 = Post.new("Продажи", "Старший менеджер", 80000, true)
  post3 = Post.new("Бухгатерия", "Бухгалтер", 40000, false)
  post4 = Post.new("Разработка", "Разработчик", 100000, false)

  posts = Post_list.new
  posts.add_post(post1)
  posts.add_post(post2)
  posts.add_post(post3)
  posts.add_post(post4)

  posts.mark_post(2)
  posts.delete_post

  posts.mark_post(3)
  posts.replace_post(post2)

  # posts.sort
  puts posts.get_post
  # puts posts
rescue ArgumentError => error
  puts "Error: " + error.message + "."
end