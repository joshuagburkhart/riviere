class MessageController < ApplicationController
  def contact
	  @usr = UserController.findUser(session[:activesess])
  end
  def create
	  @usr = UserController.findUser(session[:activesess])
	  em,msg,uid=params[:em],params[:msg]
	  if !em.nil? && em!="" && !msg.nil? && msg!=""
		  @msg = Message.new
		  @msg.email = em
		  @msg.msg = msg
		  @msg.uid = @usr.id
		  @msg.save
	  end
	  redirect_to "/index"
  end
end
