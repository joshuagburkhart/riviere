require 'digest/sha1'
class UserController < ApplicationController
  def index
	@usr=UserController.findUser(session[:activesess])
	session[:activesess] = @usr.activesess	
  end
  def UserController.random_session_id
	  rand(9999999999999999).to_s
  end
  def login
	em,pd = params[:em],params[:pd]
	if User.where("email = ?", em).exists? 
		@usr=User.where("email = ?",em).first
		if (@usr.pswd == sha1(pd))
			
			rid=UserController.random_session_id()
			@usr.activesess=rid
			@usr.save
			session[:activesess] = rid
		end
	end
	redirect_to "/index"
  end
  def logout
	@usr=UserController.findUser(session[:activesess])
	@usr.activesess = nil
	@usr.save
	redirect_to "/index"
  end
  def UserController.findUser(s)
	@sid = s
	if @sid.nil? || !User.where("activesess = ?", @sid).exists? #|| User.where("activesess = ?", @sid).first.updated_at.is-older-than-30-minutes
		grid = "g_"+UserController.random_session_id()
		@usr = User.new
		@usr.fname = "Guest"
		@usr.activesess = grid
		@usr.save
	        @sid = grid
	end
	@usr=User.where("activesess = ?", @sid).first
  end
  def join
  end
  def sha1(plain)
  	Digest::SHA1.hexdigest(plain).to_s
  end
  def create
	ln,fn,em,pd,og,oa,op=params[:ln],params[:fn],params[:em],params[:pd],params[:og],params[:oa],params[:op]
	if !ln.nil? && ln!="" && !fn.nil? && fn!="" && !em.nil? && em!="" && !pd.nil? && pd!="" && !og.nil? && og!="" && !oa.nil? && oa!="" && !op.nil? && op!=""
		rnum = UserController.random_session_id
		@usr = User.new
		@usr.activesess =  rnum
	  	@usr.lname = ln
		@usr.fname = fn
		@usr.email = em
		@usr.pswd = sha1(pd)
		@usr.organization = og
		@usr.org_address = oa
		@usr.org_pcode = op
	  	@usr.save
		session[:activesess] = rnum
	end
	redirect_to "/index"
  end
end
