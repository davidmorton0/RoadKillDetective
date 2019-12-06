require "test/unit/assertions"
include Test::Unit::Assertions

ANIMALS = ["hyena", "penguin", "bear"]

def road_kill(photo)
	identify = photo.tr("^a-z\s", "").chars
	identify_chunked = identify.chunk { |c| c }.to_a.map { |x| x[1] }
	a = []
	identify_chunked.each { |arr| a.append([arr[0], arr.length]) }
	pattern = Regexp.new("^#{a.inject("") { |pattern, (l, n)| pattern += "#{l}\{1,#{n}\}" }}$")
	forward = ANIMALS.select { |animal| pattern.match(animal) }
	reverse = ANIMALS.select { |animal| pattern.match(animal.reverse) }
	if forward.length > 0
		forward[0]
	elsif reverse.length > 0
		reverse[0]
	else
		"??"
	end
end

assert_equal(road_kill("==========h===yyyyyy===eeee=n==a========"), "hyena")
assert_equal(road_kill("======pe====nnnnnn=======================n=n=ng====u==iiii=iii==nn========================n="), "penguin")
assert_equal(road_kill("=====r=rrr=rra=====eee======bb====b======="), "bear")
assert_equal(road_kill("===       ===snake========="), "??")
assert_equal(road_kill("=========.*=\d\d\..//[)44567$$$+..)===="), "??")
