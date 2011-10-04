require '../../source/rb/multithread_examples'

describe SimpleExample do
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

describe BioUser do
	example=BioUser.new
	it "can use the bio gem" do
		example.seq1= "acgttt"
		example.seq1comp.should=="aaacgt"
		example.align1("attt","agct")
		example.align1consensus.should=="a??t"
	end
	it "can align two sequences" do
		example.align1("acgtaaatgcc","aaaacgttaatgcc")
		example.align1needw.should=="a---cgt-aaatgcc\naaaacgttaa-tgcc"
	end
end
