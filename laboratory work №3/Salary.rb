class Salary
  def get_salary
  end
end

class Fix_sal < Salary
  def initialize(fixed)
    @fixed = fixed
  end

  def get_salary
    return @fixed
  end
end

class Rub_sal < Fix_sal
  def initialize(fixed, add_rub)
    super(fixed)

    @add_rub = add_rub
  end

  def get_salary
    return super + @add_rub
  end
end

class Percent_salary < Fix_sal
  def initialize(fixed, add_percent)
    super(fixed)

    @add_percent = add_percent
  end

  def get_salary
    return (rand(10) % 2 == 0)?
             super: super + (super * 0.001 * @add_percent)
  end
end