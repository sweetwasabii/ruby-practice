class Salary
  def get_salary
  end
end

class Fixed_salary < Salary
  def initialize(fixed)
    @fixed = fixed
  end

  def get_salary
    return @fixed
  end
end

class Fined_salary < Fixed_salary
  def initialize(fixed, fine)
    super(fixed)

    @fine = fine
  end

  def get_salary
    return super - @fine
  end
end

class Ruble_salary < Fixed_salary
  def initialize(fixed, additional_rubles)
    super(fixed)

    @additional_rubles = additional_rubles
  end

  def get_salary
    return super + @additional_rubles
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

class Fined_percent_salary < Percent_salary
  def initialize(fixed, additional_percent, fine)
    super(fixed, additional_percent)

    @fine = fine
  end

  def get_salary
    return super - @fine
  end
end

class Ruble_percent_salary < Percent_salary
  def initialize(fixed, additional_rubles, additional_percent)
    super(fixed, additional_percent)

    @additional_rubles = additional_rubles
  end

  def get_salary
    return super + @additional_rubles
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