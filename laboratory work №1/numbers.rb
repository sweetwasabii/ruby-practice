# №2_1 Получить число как аргумент программы. Найти сумму цифр числа.

def task2_1
  print "Input the number: "
  number = gets.chomp.to_i

  print "Sum of digits: #{sum_digits(number)}"
end

def sum_digits(number)
  sum = 0

  while number != 0 do
    sum += number % 10
    number /= 10
  end

  return sum
end

# task2_1

=begin
№2_2 Вынести нахождение суммы цифр числа в отдельный метод.
Реализовать методы поиска максимальной и минимальной цифры числа, произведения цифр числа.
=end

def max_digit(number)
  max = 0

  begin
    digit = number % 10
    max = (digit > max)? digit: max
    number /= 10
  end while number != 0

  return max
end

# puts max_digit(5823)

def min_digit(number)
  min = 9

  begin
    digit = number % 10
    min = (digit < min)? digit: min
    number /= 10
  end while number != 0

  return min
end

# puts min_digit(5823)

def mult_digits(number)
  mult = 1

  begin
    mult *= number % 10
    number /= 10
  end while number != 0

  return mult
end

# puts mult_digits(5823)

=begin
№2_3 Составить 3 метода для работы с цифрами или делителей числа на основании варианта.
Ввести отдельный аргумент ПРОГРАММЫ, в котором указывать, какой метод должен отработать из 7 составленных.
Если не передан ни один параметр, программа просто выводит Hello World.

Вариант №11:

Метод 1. Найти количество делителей числа, не делящихся на 3.
Метод 2. Найти минимальную нечетную цифру числа.
Метод 3. Найти сумму всех делителей числа, взаимно простых с суммой цифр числа
и не взаимно простых с произведением цифр числа.
=end

def task2_3_1(number)
  dividers = 0

  if number != 0
    dividers += 1
    if number % 3 != 0
      dividers += 1
    end
  end

  sq = Math.sqrt(number).to_i

  (2..sq).each { |i|
    if number % i == 0
      dividers += (i % 3 == 0)? 0: 1
      dividers += (number / i % 3 == 0 and i ** 2 != number)? 0: 1
    end
  }

  return dividers
end

# puts task2_3_1(33)

def task2_3_2(number)
  if number == 0
    raise ArgumentError, "The number can't be 0."
  end

  min_odd_digit = 9
  found_odd_digit = false

  while number != 0
    digit = number % 10
    if digit % 2 != 0
      found_odd_digit = true

      if digit < min_odd_digit
        min_odd_digit = digit
      end
    end

    number /= 10
  end

  unless found_odd_digit
    raise ArgumentError, "There're no odd digits in the number."
  end

  return min_odd_digit
end

# puts task2_3_2(5823)
# puts task2_3_2(0)
# puts task2_3_2(22)

def find_GCD(a, b)
  if a == 0 or b == 0
    raise ArgumentError, "One of the numbers is 0."
  end

  while a != b
    (a > b)? a -= b: b -= a
  end

  return a
end

# puts find_GCD(10, 25)
# puts find_GCD(10, 0)
# puts find_GCD(11, 27)

def are_coprime(a, b)
  return find_GCD(a, b) == 1
end

# puts are_coprime(10, 25)
# puts are_coprime(10, 0)
# puts are_coprime(11, 27)

def task2_3_3(number)
  sum = sum_digits(number)
  mult = mult_digits(number)

  sq = Math.sqrt(number).to_i
  result = 0

  (2..sq).each { |i|
    if number % i == 0
      if are_coprime(i, sum) and not are_coprime(i, mult)
        result += i
      end

      remainder = number / i
      if i ** 2 != number and are_coprime(remainder, sum) and not are_coprime(remainder, mult)
        result += remainder
      end
    end
  }

  if are_coprime(number, sum) and not are_coprime(number, mult)
    result += number
  end

  return result
end

# puts task2_3_3(52)
# sum = 7 mult = 10
# 1 2 26 4 13 52
# 2 + 4 + 26 + 52 = 84

=begin
№3 Списки

1. Написать методы, которые находят минимальный, максимальный элементы,
сумму и произведение элементов. Каждая операция в отдельном методе.
Решить задачу с помощью циклов.

2. Написать программу, которая принимает как аргумент два значения.
Первое значение говорит, какой из методов задачи 1 выполнить,
второй говорит о том, откуда читать список, с клавиатуры, или из файла.
Если из файла, то третьим аргументом должен быть написан адрес файла.
Далее необходимо прочитать массив и выполнить метод.
=end

def get_list_min(*list)
  if list.size == 0
    raise ArgumentError, "Array size is 0."
  end

  min = list[0]
  list.each { |element|
    if element < min
      min = element
    end
  }

  return min
end

# puts get_list_min(5, 2, 8, 3)
# puts get_list_min()

def get_list_max(*list)
  if list.size == 0
    raise ArgumentError, "Array size is 0."
  end

  max = list[0]
  list.each { |element|
    if element > max
      max = element
    end
  }

  return max
end

# puts get_list_max(5, 2, 8, 3)
# puts get_list_max()

def get_list_sum(*list)
  if list.size == 0
    raise ArgumentError, "Array size is 0."
  end

  sum = 0
  list.collect { |element|
    sum += element
  }

  return sum
end

# puts get_list_sum(5, 2, 8, 3)
# puts get_list_sum()

def get_list_mult(*list)
  if list.size == 0
    raise ArgumentError, "Array size is 0."
  end

  mult = 1
  list.collect { |element|
    mult *= element
  }

  return mult
end

# puts get_list_mult(5, 2, 8, 3)
# puts get_list_mult()

def read_file_list(file_name)
  file = File.new(file_name, "r:UTF-8")
  content = file.read

  list = []
  content.split.each { |element|
    list.push element.to_i
  }

  return list
end

# puts read_file_list("list.txt")

def read_keyboard_list
  print("Input list: ")

  list = []
  gets.chomp.split.each { |element|
    list.push element.to_i
  }

  return list
end

# puts read_keyboard_list

def task3_2(read_from_keyboard, method_number, *file_name)
  if read_from_keyboard
    print("Input list: ")
    list = read_keyboard_list
  else
    list = read_file_list(file_name.first)
  end

  method_result = case method_number
  when 1
    get_list_min(*list)
  when 2
    get_list_max(*list)
  when 3
    get_list_sum(*list)
  when 4
    get_list_mult(*list)
  else
    raise ArgumentError, "The method number must be in the range [1, 4]."
           end

  puts "Method's result: " + method_result.to_s
end

# task3_2(true, 1)
# task3_2(true, 2)
# task3_2(true, 3)
# task3_2(true, 4)

# task3_2(false, 1, "list.txt")
# task3_2(false, 2, "list.txt")
# task3_2(false, 3, "list.txt")
# task3_2(false, 4, "list.txt")

=begin
№4 Методы, принимающие блок как аргумент

Решить предложенные задачи по вариантам.
Задание в отдельную программу. БЕЗ ИСПОЛЬЗОВАНИЯ ЦИКЛОВ.
Чтение из файла или с клавиатуры.

Вариант 11, задачи: 11, 23, 35, 47, 59
=end

# 11. Дан целочисленный массив, в котором лишь один элемент отличается от остальных.
# Необходимо найти значение этого элемента.

def task4_11(*list)
  return list.find { |element| list.count(element) == 1}
end

# list = read_keyboard_list
# puts "Method's result: " + task4_11(*list).to_s
# 2 3 2 3 3 4 5 4 4
# 5

# 23. Дан целочисленный массив. Необходимо найти два наименьших элемента.

def task4_23(*list)
  return list.min(2)
end

# list = read_keyboard_list
# puts "Method's result: " + task4_23(*list).to_s
# 3 5 4 2 3 3 1 6 -> 1 2
# 3 5 4 2 3 3 2 6 -> 2 2

# 35. Дано вещественное число R и массив вещественных чисел.
# Найти элемент массива, который наиболее близок к данному числу.

def task4_35(number, *list)
  dif = (number - list.first).abs
  x = list.first

  list.each { |element|
    if (number - element).abs < dif
      dif = (number - element).abs
      x = element
    end
  }

  return x
end

# puts "Method's result: " + task4_35(6.5, 1.2, 3.45, 4.21, 7.8, 2.3, 4.5).to_s
# 6.5
# 1.2 3.45 4.21 7.8 2.3 4.5
# 7.8

# 47. Для введенного списка положительных чисел построить список
# всех положительных делителей элементов списка без повторений.

def get_dividers(number)
  list = []

  if number != 0
    list.push(1)
    list.push(number)
  end

  sq = Math.sqrt(number).to_i

  (2..sq).each { |i|
    if number % i == 0
      list.push(i)
      if i * i != number
        list.push(number / i)
      end
    end
  }

  return list
end

# puts get_dividers(10)
# puts get_dividers(17)
# puts get_dividers(36)

def task4_47(*list)
  dividers = []

  list.each { |element1|
    get_dividers(element1).each { |element2|
      unless dividers.include?(element2)
        dividers.push(element2)
      end
    }
  }

  return dividers.sort
end

# list = read_keyboard_list
# puts "Method's result: " + task4_47(*list).to_s

# 10 17 12 9 -> 1 2 3 4 5 6 9 10 12 17

# 59. Дан список. Построить новый список из квадратов неотрицательных чисел,
# меньших 100 и встречающихся в массиве больше 2 раз.

def task4_59(*list)
  use = []
  sq = []

  list.each { |element|
    if element < 100 and list.count(element) > 2 and not use.include?(element)
      use.push(element)
      sq.push(element ** 2)
    end
  }

  return sq.sort
end

# list = read_keyboard_list
# puts "Method's result: " + task4_59(*list).to_s
# 2 3 2 3 2 3 4 5 4 4 -> 4 9 16

=begin
№4_2 Строки

Решить задачи по вариантам.
Решить с помощью методов класса String.

Вариант 11, задачи: 5, 7, 14
=end

# 5. Дана строка. Необходимо перемешать все символы строки в случайном порядке.

def task4_2_5(str)
  size = str.size
  index = 0
  using_indexes = []
  rnd = Random.new

  str.each_char { |symbol|
    irand = rnd.rand(size)
    unless using_indexes.include?(irand)
      str[index] = str[irand]
      str[irand] = symbol
      using_indexes.push(irand)
    end
    index += 1
  }

  return str
end

# puts "Method's result: " + task4_2_5("abcdefg")

# 7. Дана строка, состоящая из символов латиницы.
# Необходимо проверить образуют ли прописные символы этой строки палиндром.

def task4_2_7(str)
  index = 0
  letters = ""

  str.each_byte do |ascii|
    if ascii >= 97 and ascii <= 122
      letters += ascii.chr
    end
  end

  return letters == letters.reverse
end

# puts "Method's result: " + task4_2_7("aVbNcAUcba").to_s
# puts "Method's result: " + task4_2_7("abbcd").to_s

# 14. Дана строка в которой записаны слова через пробел.
# Необходимо упорядочить слова по количеству букв в каждом слове.

def task4_2_14(str)
  list = str.split
  sizes = []

  list.each { |word|
    sizes.push(word.size)
  }

  sizes.sort
  new_str = ""

  sizes.each { |word_size|
    word = list.select {|element| element.size == word_size}.first
    new_str += word + " "
    list.delete(word)
  }

  return new_str.delete_suffix(" ")
end

# puts task4_2_14("abcd abc abcdef ab aaaaaaa")



