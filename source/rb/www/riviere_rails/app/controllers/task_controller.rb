class TaskController < ApplicationController
  def index
	@tasks = Task.all
  end
  def create
	  s1,s2=params[:seq1],params[:seq2]
	  if !s1.nil? && !s1=="" && !s2.nil? && !s2==""
	  	@tsk = Task.new
	  	@tsk.base_sequence1 = s1
	  	@tsk.base_sequence2 = s2
	  	@tsk.alignment_sequence = needW(s1,s2)
	  	@tsk.save
	  end
	  redirect_to :action => "index"
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
		puts printArray(reseq1).reverse
		puts printArray(reseq2).reverse

		return "#{printArray(reseq1).reverse},#{printArray(reseq2).reverse}"
	end
	def printArray(a)
		if RUBY_VERSION < "1.9"
			a.to_s
		else
			a.join.to_s
		end
	end
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
end
