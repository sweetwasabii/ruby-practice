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

def min_digit(number)
  min = 9

  begin
    digit = number % 10
    min = (digit < min)? digit: min
    number /= 10
  end while number != 0

  return min
end

def mult_digits(number)
  mult = 1

  begin
    mult *= number % 10
    number /= 10
  end while number != 0

  return mult
end