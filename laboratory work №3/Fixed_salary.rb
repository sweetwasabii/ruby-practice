require_relative 'Salary.rb'

class Fixed_salary < Salary
  def initialize(fixed)
    @fixed = fixed
  end

  def get_salary
    return @fixed
  end
end