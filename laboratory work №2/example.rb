a = ["abc", "def", "cas"]

puts a[0].object_id
puts a[1].object_id
puts a[2].object_id
puts "\n"

a.each do |elem|
  puts elem.object_id
  elem[0] = "h"
end
puts "\n"

a.each { |elem| puts elem}