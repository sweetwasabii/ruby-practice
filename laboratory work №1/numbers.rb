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