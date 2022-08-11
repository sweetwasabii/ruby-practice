require_relative 'Fixed_salary.rb'

class Ruble_salary < Fixed_salary
  def initialize(salary, additional_rubles)
    super(salary)

    @additional_rubles = additional_rubles
  end

  def get_salary
    return super + @additional_rubles
  end
end