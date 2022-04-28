=begin
№1_1 Установить компилятор и текстовый редактор.
Реализовать и вызвать Hello World c комментарием.
=end

def task1_1
  print "Hello, World!";
end

=begin
№1_2 Принять имя пользователя как аргумент программы.
Поздороваться с пользователем с использованием форматирования строки.
Рассмотреть тип строка, получить все методы, рассмотреть irb режим.
=end

def task1_2_1
  print "Input username: ";
  username = gets.chomp;
  print "Hello, #{username}!";
end

def task1_2_2
  print "Методы класса String: #{String.instance_methods}";
end

=begin
№1_3 Продолжение предыдущего задания. Спросить какой язык у пользователя любимый,
в случае, если это ruby, ответить что пользователь подлиза, иначе обязательно ответить,
что скоро будет ruby и поставить различный комментарий для каждого языка.
Рассмотреть условный оператор и разные способы его построения Рассмотреть оператор switch case.
=end

def task1_3_1
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

def task1_3_2
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

def task1_3_3
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

=begin
№1_4 Продолжение предыдущего задания.
Попросить пользователя ввести команду языка ruby. И команду OC.
Выполнить команду руби и команду операционной системы.

Вопросы:

1. Что такое аргумент программы? Для чего он может быть полезен
2. Как перейти в irb режим? Продемонстрировать.
3. Как получить методы класса и методы объекта? В чем разница?
4. Описать 5 методов объекта класса строка.
5. Расскажите, что такое форматирование строки? Приведите пример.?
6. Покажите 4 способа реализации условного оператора в ruby.
7. Как выполнить команду языка, хранящуюся в строке?
8. Как выполнить команду ОС, хранящуюся в строке?
=end

def task1_4
  print "Input the ruby command: ";
  ruby_command = gets.chomp
  puts "";

  print "Input the OS command: ";
  os_command = gets.chomp
  puts "";
end