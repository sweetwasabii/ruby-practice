require_relative 'Salary.rb'

class Ruble_percent_salary < Percent_salary
  def initialize(fixed, additional_percent, additional_rubles)
    super(fixed, additional_percent)

    @additional_rubles = additional_rubles
  end

  def get_salary
    return super + @additional_rubles
  end

  def to_hash
    salary_hash = super
    salary_hash[:salary_class] = self.class.name
    salary_hash[:additional_rubles] = @additional_rubles

    return salary_hash
  end
end

class Premium_ruble_percent_salary < Ruble_percent_salary
  def initialize(fixed, additional_percent, additional_rubles, premium)
    super(fixed, additional_percent, additional_rubles)

    @premium = premium
  end

  def get_salary
    return super + @premium
  end

  def to_hash
    salary_hash = super
    salary_hash[:salary_class] = self.class.name
    salary_hash[:premium] = @premium

    return salary_hash
  end
end

class Fined_ruble_percent_salary < Ruble_percent_salary
  def initialize(fixed, additional_percent, additional_rubles, fine)
    super(fixed, additional_percent, additional_rubles)

    @fine = fine
  end

  def get_salary
    return super - @fine
  end

  def to_hash
    salary_hash = super
    salary_hash[:salary_class] = self.class.name
    salary_hash[:fine] = @fine

    return salary_hash
  end
end

class Premium_fined_ruble_percent_salary < Fined_ruble_percent_salary
  def initialize(fixed, additional_percent, additional_rubles, fine, premium)
    super(fixed, additional_percent, additional_rubles, fine)

    @premium = premium
  end

  def get_salary
    return super + @premium
  end

  def to_hash
    salary_hash = super
    salary_hash[:salary_class] = self.class.name
    salary_hash[:premium] = @premium

    return salary_hash
  end
end