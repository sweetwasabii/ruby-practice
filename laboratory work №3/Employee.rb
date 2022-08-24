class Employee
  # поля: name, surname, patronymic, birth_data, passport, phone_number, address, email_address
  attr_writer :name, :surname, :patronymic, :birth_data,
              :passport, :phone_number, :address, :email_address

  def initialize(employee_hash)
    @name = employee_hash[:name].clone
    @surname = employee_hash[:surname].clone
    @patronymic = employee_hash[:patronymic].clone
    @birth_data = employee_hash[:birth_data].clone
    @passport = employee_hash[:passport].clone
    @phone_number = employee_hash[:phone_number].clone
    @address = employee_hash[:address].clone
    @email_address = employee_hash[:email_address].clone
  end

  def name
    return @name.clone
  end

  def surname
    return @surname.clone
  end

  def patronymic
    return @patronymic.clone
  end

  def birth_data
    return @birth_data.clone
  end

  def passport
    return @passport.clone
  end

  def phone_number
    return @phone_number.clone
  end

  def address
    return @address.clone
  end

  def email_address
    return @email_address.clone
  end
end

class Skilled_employee < Employee
  def initialize(employee_hash, work_experience, description)
    super(employee_hash)

    @work_experience = work_experience
    @description = description
  end
end