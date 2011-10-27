class GreetingController < ApplicationController
  def index
  	@age=8
	@table={"headings" => ["addend", "addend", "sum"],
		"body"	   => [[1,1,2],[1,2,3],[1,3,4]]
		}
  end
end
