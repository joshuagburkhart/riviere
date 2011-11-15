class MessageController < ApplicationController
  def contact
	  uid=params[:uid]
	  @uid = uid
  end
  def create
	  em,msg,uid=params[:em],params[:msg],params[:uid]
	  if !em.nil? && em!="" && !msg.nil? && msg!=""
		  @msg = Message.new
		  @msg.email = em
		  @msg.msg = msg
		  if !uid.nil? && uid!=""
		  	@msg.uid = uid
		  end
		  @msg.save
	  end
	  redirect_to "/index"
  end
end
