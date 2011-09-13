require '../../source/rb/multithread_examples'

describe SimpleExample, do
	it "returns an array with correct value" do
		example=SimpleExample.new
		10.times do
			example.addSequence "ACTGUAGCTU"
		end	
		example.listSequence(0).should=="ACTGUAGCTU"
	end	
end

describe TwoThreadExample do
	it "can add with two threads" do
		example=TwoThreadExample.new
		example.addSequence1 "12345"
		example.addSequence2 "65432"
		example.sum.should=="77777"
	end
end
