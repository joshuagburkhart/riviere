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
	def needW(seq1, seq2)
		s={
			"A" => {"A" => 1, "T" => 0, "C" => 0, "G" => 0},
			"T" => {"A" => 0, "T" => 1, "C" => 0, "G" => 0},
			"C" => {"A" => 0, "T" => 0, "C" => 1, "G" => 0},
			"G" => {"A" => 0, "T" => 0, "C" => 0, "G" => 1}
		}
		w=-1
		m=seq1.length
		n=seq2.length
		
		#create matrix
		matrix=Array.new(m+1) do
			Array.new(n+1)
		end

		#fill matrix
		(m+1).times do |i|
			matrix[i][0]=(i*w)
		end
		(n+1).times do |j|
			matrix[0][j]=(j*w)
		end
		(1..m).each do |i|
			(1..n).each do |j|
				res1=seq1.split('')[i-1]
				res2=seq2.split('')[j-1]
				score=s[res1.upcase][res2.upcase]
				neighbors=[matrix[i][j-1],matrix[i-1][j],matrix[i-1][j-1]]
				max=neighbors.max
				matrix[i][j]=score+max
			end
		end

		#traceback

		


		
		matrix.size.times do |i| puts matrix[i].to_s end
	end
	def seq1comp
		Bio::Sequence::NA.new(@seq1).complement
	end
	def align1(sq1,sq2)
		@a=Bio::Alignment.new([Bio::Sequence::NA.new(sq1),Bio::Sequence::NA.new(sq2)])
	end
	def align1consensus
		@a.consensus
	end
	def align1needw
		needW(@a[0],@a[1])
	end
end
