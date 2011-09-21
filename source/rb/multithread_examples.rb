require 'rubygems'
require 'bio'

class SimpleExample
	def addSequence(seq)
		@seq_list=Array.new if @seq_list.nil?
		@seq_list << seq
	end
	def listSequence(idx)
		@seq_list[idx]
	end
end	

class TwoThreadExample
	def initialize
		@seq3=[]	
		@mutex=Mutex.new
	end
	def addSequence1(array1)
		@seq1=array1
	end
	def addSequence2(array2)
		@seq2=array2
	end
	def sum
		t1=Thread.new{sumSeq(@seq1)}
		t2=Thread.new{sumSeq(@seq2)}
		t1.join
		t2.join
		@seq3.to_s.tr('\[,\ \]','')
	end
	def sumSeq(sq)
		sq.size.times do |i|
			@mutex.synchronize do
			local_val=sq.chars.to_a[i].to_i
			@seq3[i].nil? ? @seq3[i]=local_val : @seq3[i]+=local_val
			end		
		end
	end
end

class BioUser
	attr_accessor :seq1
	def seq1comp
		Bio::Sequence::NA.new(@seq1).complement
	end
	def align1(sq1,sq2)
		@a=Bio::Alignment.new([Bio::Sequence::NA.new(sq1),Bio::Sequence::NA.new(sq2)])
	end
	def align1consensus
		@a.consensus
	end
end
