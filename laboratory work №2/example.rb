class Example
  attr_writer :name, :age, :features
  attr_accessor :age, :features

  def initialize(name, age, features)
    @name = name
    @age = age
    @features = features
    puts "привет"
  end

  def name
    return @name.clone
  end

  def age
    return @age
  end

  def features
    return @features.map {|feature| feature.clone}
  end

  def get_example
    return Example.new(@name.clone, @age, @features.map {|feature| feature.clone})
  end
end


Masha = Example.new("Маша", 78, ["прыгать", "бегать", "какать"])
Sasha = Masha.clone
# Sasha.features[0] = "думать"

if 2 < 5
  puts "hekke"
end

# puts Masha.name.object_id
# puts Sasha.name.object_id
# puts "\n"
# puts Masha.age.object_id
# puts Sasha.age.object_id
# puts "\n"
# puts Masha.features.object_id
# puts Sasha.features.object_id
# puts "\n"
#
# puts Masha.object_id
# puts Sasha.object_id
#
# Sasha.name[0] = "К"
# Sasha.features[0] = "думать"
#
# # puts Sasha.name
# # puts Sasha.age
# # puts Sasha.features.to_s
#
# # name = Masha.name
# # name[0] = "К"
# #
# # age = Masha.age
# #
# # a = true
# # b = a
# # b = false
# #
# # puts a
# #
# # features = Masha.features
# # features[1][0] = "k"
# # features = ["ab", "cd"]
#
# puts Masha.name
# puts Masha.age
# puts Masha.features.to_s