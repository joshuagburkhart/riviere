class SimpleExample
	def initialize
		#nothing here	
	end	
	def addSequence(seq)
		@seq_list=Array.new if @seq_list.nil?
		@seq_list << seq
	end
	def listSequence(idx)
		@seq_list[idx]
	end
end	
