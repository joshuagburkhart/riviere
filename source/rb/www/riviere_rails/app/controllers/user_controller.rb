class UserController < ApplicationController
  def join
  end
  def create
	ln,fn,em,pd,og,oa,op=params[:ln],params[:fn],params[:em],params[:pd],params[:og],params[:oa],params[:op]
	if !ln.nil? && ln!="" && !fn.nil? && fn!="" && !em.nil? && em!="" && !pd.nil? && pd!="" && !og.nil? && og!="" && !oa.nil? && oa!="" && !op.nil? && op!=""
		@usr = User.new
	  	@usr.lname = ln
		@usr.fname = fn
		@usr.email = em
		@usr.pswd = pd
		@usr.organization = og
		@usr.org_address = oa
		@usr.org_pcode = op
	  	@usr.save
	end
	redirect_to :action => "join"
  end
end
