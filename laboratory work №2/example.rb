class Example
  def initialize(samp)
    @samp = samp
  end

  def samp
    return @samp.clone
  end

=begin
  def samp
    return @samp
  end
=end

=begin
  def samp
    return Array.new(@samp)
  end

  def samp=(samp)
    if samp[0] > 5
      @samp = samp
    end
  end
=end

end


samp = Example.new("привет")
new_samp = samp.samp
new_samp[0] = "h"
puts samp.samp


=begin
samps = Example.new([1, 2, 3, 4, 5])
puts samps.samp.to_s + "\n"

some = samps.samp
some[0] = 10

puts samps.samp.to_s
=end

=begin
a = "first"
b = a.dup

b[0] = "g"
b[1] = "j"

puts a + " " + b
=end

