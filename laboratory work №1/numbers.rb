# №2_1 Получить число как аргумент программы. Найти сумму цифр числа.

def task2_1
  print "Input the number: "
  number = gets.chomp.to_i

  print "Sum of digits: #{sum_digits(number)}"
end

def sum_digits(number: Integer)
  sum = 0

  while number != 0 do
    sum += number % 10
    number /= 10
  end

  return sum
end

=begin
№2_2 Вынести нахождение суммы цифр числа в отдельный метод.
Реализовать методы поиска максимальной и минимальной цифры числа, произведения цифр числа.
=end

def max_digit(number: Integer)
  max = 0

  begin
    digit = number % 10
    max = (digit > max)? digit: max
    number /= 10
  end while number != 0

  return max
end

def min_digit(number: Integer)
  min = 9

  begin
    digit = number % 10
    min = (digit < min)? digit: min
    number /= 10
  end while number != 0

  return min
end

def mult_digits(number: Integer)
  mult = 1

  begin
    mult *= number % 10
    number /= 10
  end while number != 0

  return mult
end

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

def task2_3_1(number: Integer)
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

def task2_3_2(number: Integer)
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

def task2_3_3(number: Integer)
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

def are_coprime(a: Integer, b: Integer)
  return find_GCD(a, b) == 1
end

def find_GCD(a: Integer, b: Integer)
  if a == 0 or b == 0
    raise ArgumentError, "One of the numbers is 0."
  end

  while a != b
    (a > b)? a -= b: b -= a
  end

  return a
end

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

def min_of_array(array: Array)
  if array.size == 0
    raise ArgumentError, "Array size is 0."
  end

  min = array[0]
  array.each { |item|
    if item < min
      min = item
    end
  }
end

def max_of_array(array: Array)
  if array.size == 0
    raise ArgumentError, "Array size is 0."
  end

  max = array[0]
  array.each { |item|
    if item < max
      max = item
    end
  }
end

def sum_of_array(array: Array)
  if array.size == 0
    raise ArgumentError, "Array size is 0."
  end

  sum = 0
  array.each { |item|
    sum += item
  }
end

def mult_of_array(array)
  if array.size == 0
    raise ArgumentError, "Array size is 0."
  end

  mult = 1
  array.each { |item|
    sum *= item
  }
end