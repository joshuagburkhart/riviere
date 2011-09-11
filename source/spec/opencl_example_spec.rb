require '../rb/opencl_example'
require 'quick_opencl'

describe SimpleExample, do
	it "returns an array with correct value" do
		example=SimpleExample.new
		10.times do
			example.addSequence "ACTGUAGCTU"
		end	
		example.listSequence(0).should=="ACTGUAGCTU"
	end	
end
