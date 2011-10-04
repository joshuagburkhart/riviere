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
	def printPrettyMatrix(seq1,seq2,matrix)
		puts
		print "     "
		seq2.size.times do |x|
			print " #{seq2.split('')[x]} "
		end
		puts
		print "  " 
		matrix[0].size.times do |y|
			print "[#{matrix[0][y]}]"
		end
		puts
		(1..matrix.size-1).each do |i| print "#{seq1.split('')[i-1]} "
			matrix[i].size.times do |j|
				print "[#{matrix[i][j]}]"
			end
		puts
		end	
		puts
	end
	def needW(seq1, seq2)
		s={
			"A" => {"A" => 1, "T" => 0, "C" => 0, "G" => 0},
			"T" => {"A" => 0, "T" => 1, "C" => 0, "G" => 0},
			"C" => {"A" => 0, "T" => 0, "C" => 1, "G" => 0},
			"G" => {"A" => 0, "T" => 0, "C" => 0, "G" => 1}
		}
		w=0
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
				neighbors=[matrix[i][j-1]+w,matrix[i-1][j]+w,matrix[i-1][j-1]+score]
				matrix[i][j]=neighbors.max
			end
		end

		#traceback
		x,y=m-1,n-1
		reseq1=[seq1.split('')[x]]
		reseq2=[seq2.split('')[y]]
		while x>0 && y>0 do
			if matrix[x][y-1]>matrix[x-1][y-1] && matrix[x][y-1]>matrix[x-1][y] 
				y=y-1
				reseq1 << "-"
				reseq2 << seq2.split('')[y]
			elsif	matrix[x-1][y]>matrix[x-1][y-1] && matrix[x-1][y]>matrix[x][y-1] 
				x=x-1
				reseq1 << seq1.split('')[x]
				reseq2 << "-"
			else 
				x=x-1
				y=y-1
				reseq1 << seq1.split('')[x]
				reseq2 << seq2.split('')[y]
			end
		end
		

		printPrettyMatrix(seq1,seq2,matrix)
		puts reseq1.to_s.reverse
		puts reseq2.to_s.reverse

		"#{reseq1.to_s.reverse}\n#{reseq2.to_s.reverse}"
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
