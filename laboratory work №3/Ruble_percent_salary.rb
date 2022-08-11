require_relative 'Salary.rb'

class Ruble_percent_salary < Percent_salary
  def initialize(fixed, additional_rubles, additional_percent)
    super(fixed, additional_percent)

    @additional_rubles = additional_rubles
  end

  def get_salary
    return super + @additional_rubles
  end
end

class Premium_ruble_percent_salary < Ruble_percent_salary
  def initialize(fixed, additional_rubles, additional_percent, premium)
    super(fixed, additional_rubles, additional_percent)

    @premium = premium
  end

  def get_salary
    return super + @premium
  end
end

class Fined_ruble_percent_salary < Ruble_percent_salary
  def initialize(fixed, additional_rubles, additional_percent, fine)
    super(fixed, additional_rubles, additional_percent)

    @fine = fine
  end

  def get_salary
    return super - @fine
  end
end

class Premium_fined_ruble_percent_salary < Fined_ruble_percent_salary
  def initialize(fixed, additional_rubles, additional_percent, fine, premium)
    super(fixed, additional_rubles, additional_percent, fine)

    @premium = premium
  end

  def get_salary
    return super + @premium
  end
end