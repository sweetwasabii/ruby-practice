class Salary
  def get_salary
  end

  def to_hash
    return {
      :salary_class => self.class.name
    }
  end
end

class Fixed_salary < Salary
  def initialize(fixed)
    @fixed = fixed
  end

  def get_salary
    return @fixed
  end

  def to_hash
    salary_hash = super
    salary_hash[:salary_class] = self.class.name
    salary_hash[:fixed] = @fixed

    return salary_hash
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

  def to_hash
    salary_hash = super
    salary_hash[:salary_class] = self.class.name
    salary_hash[:premium] = @premium

    return salary_hash
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

  def to_hash
    salary_hash = super
    salary_hash[:salary_class] = self.class.name
    salary_hash[:fine] = @fine

    return salary_hash
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

  def to_hash
    salary_hash = super
    salary_hash[:salary_class] = self.class.name
    salary_hash[:premium] = @premium

    return salary_hash
  end
end