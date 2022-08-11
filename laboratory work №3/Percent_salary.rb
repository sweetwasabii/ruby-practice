require_relative 'Salary.rb'

class Percent_salary < Fixed_salary
  def initialize(fixed, additional_percent)
    super(fixed)

    @additional_percent = additional_percent
  end

  def get_salary
    return (rand(10) % 2 == 0)?
             super: super + (super * 0.001 * @additional_percent)
  end
end

class Premium_percent_salary < Percent_salary
  def initialize(fixed, additional_percent, premium)
    super(fixed, additional_percent)

    @premium = premium
  end

  def get_salary
    return super + @premium
  end
end

class Fined_percent_salary < Percent_salary
  def initialize(fixed, additional_percent, fine)
    super(fixed, additional_percent)

    @fine = fine
  end

  def get_salary
    return super - @fine
  end
end

class Premium_fined_percent_salary < Fined_percent_salary
  def initialize(fixed, additional_percent, fine, premium)
    super(fixed, additional_percent, fine)

    @premium = premium
  end

  def get_salary
    return super + @premium
  end
end