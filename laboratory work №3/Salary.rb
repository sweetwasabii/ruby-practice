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

class Premium_salary < Fixed_salary
  def initialize(fixed, premium)
    super(fixed)

    @premium = premium
  end

  def get_salary
    return super + @premium
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

class Premium_fined_salary < Fined_salary
  def initialize(fixed, fine, premium)
    super(fixed, fine)

    @premium = premium
  end

  def get_salary
    return super + @premium
  end
end