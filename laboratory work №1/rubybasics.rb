=begin
№1 Установить компилятор и текстовый редактор.
Реализовать и вызвать Hello World c комментарием.
=end

def task1
  print "Hello, World!";
end

=begin
№2 Принять имя пользователя как аргумент программы.
Поздороваться с пользователем с использованием форматирования строки.
Рассмотреть тип строка, получить все методы, рассмотреть irb режим.
=end

def task2_1
  print "Input username: ";
  username = gets.chomp;
  print "Hello, #{username}!";
end

def task2_2
  print "Методы класса String: #{String.instance_methods}";
end

=begin
№3 Продолжение предыдущего задания. Спросить какой язык у пользователя любимый,
в случае, если это ruby, ответить что пользователь подлиза, иначе обязательно ответить,
что скоро будет ruby и поставить различный комментарий для каждого языка.
Рассмотреть условный оператор и разные способы его построения Рассмотреть оператор switch case.
=end

def task3_1
  puts "Which is your favorite programming language?";
  print ":> ";

  language = gets.chomp.capitalize
  puts "";

  if language == "Ruby"
    print "Who are you trying to fool? ";
  else
    print "Soon it will be Ruby, buddy..";
  end
end

def task3_2
  puts "Which is your favorite programming language?";
  print ":> ";

  language = gets.chomp.capitalize
  puts "";

  if language == "Ruby"
    print "Who are you trying to fool?";
  elsif language == "Kotlin" || language == "Prolog"
    print "Forget about functional and logical programming.";
  else
    print "Soon it will be Ruby, buddy..";
  end
end

def task3_3
  puts "Which is your favorite programming language?";
  print ":> ";

  language = gets.chomp.capitalize
  puts "";

  case language
  when "Ruby"
    print "Who are you trying to fool?";
  when "Kotlin", "Prolog"
    print "Forget about functional and logical programming.";
  else
    print "Soon it will be Ruby, buddy..";
  end
end