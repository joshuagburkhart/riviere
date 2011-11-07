class TaskController < ApplicationController
  def index
	@tasks = Task.all
  	@age=8
	@table={"headings" => ["addend", "addend", "sum"],
		"body"	   => [[1,1,2],[1,2,3],[1,3,4]]
		}
  end
  def create
	  @seq=params[:seq]
	  @tsk = Task.new
	  @tsk.base_sequence1 = @seq
	  puts "@tsk.base_sequence1 set to #{@tsk.base_sequence1}"
	  @tsk.save
	  redirect_to :action => "index"
  end
end
