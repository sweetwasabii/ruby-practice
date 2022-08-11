require_relative 'Salary.rb'

class Ruble_salary < Fixed_salary
  def initialize(fixed, additional_rubles)
    super(fixed)

    @additional_rubles = additional_rubles
  end

  def get_salary
    return super + @additional_rubles
  end
end

class Premium_ruble_salary < Ruble_salary
  def initialize(fixed, additional_rubles, premium)
    super(fixed, additional_rubles)

    @premium = premium
  end

  def get_salary
    return super + @premium
  end
end

class Fined_ruble_salary < Ruble_salary
  def initialize(fixed, additional_rubles, fine)
    super(fixed, additional_rubles)

    @fine = fine
  end

  def get_salary
    return super - @fine
  end
end

class Premium_fined_ruble_salary < Fined_ruble_salary
  def initialize(fixed, additional_rubles, fine, premium)
    super(fixed, additional_rubles, fine)

    @premium = premium
  end

  def get_salary
    return super + @premium
  end
end