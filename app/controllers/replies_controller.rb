class RepliesController < ApplicationController

  before_filter :authenticate, :only => [:index,:show,:edit,:new ,:create,:update,:destroy,:voteup,:votedown]

  def authenticate
    if session[:userid].to_s.nil? || session[:userid].to_s.empty?
      redirect_to page_home_path , notice: "You are not authorized to view this page, Please Log in"
    end
  end

  # GET /replies
  # GET /replies.json
  def index
    @replies = Reply.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @replies }
    end
  end

  # GET /replies/1
  # GET /replies/1.json
  def show
    @reply = Reply.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reply }
    end
  end

  # GET /replies/new
  # GET /replies/new.json
  def new
    @reply = Reply.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reply }
    end
  end

  # GET /replies/1/edit
  def edit
    @reply = Reply.find(params[:id])
    @replydescription = @reply.replydescription

  end

  # POST /replies
  # POST /replies.json
  def create
    @reply = Reply.new(params[:reply])

    respond_to do |format|
      if @reply.save
        format.html { redirect_to @reply, notice: 'Reply was successfully created.' }
        format.json { render json: @reply, status: :created, location: @reply }
      else
        format.html { render action: "new" }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /replies/1
  # PUT /replies/1.json
  def update
    @reply = Reply.find(params[:id])
    @reply.replydescription = params[:replydescription]
    respond_to do |format|
      if @reply.update_attributes(params[:reply])
        format.html { redirect_to :controller => "replies" , :action => "master", notice: 'Reply was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  def master



    if params[:commit]
      replydesc = params[:reply]
      post_id = session[:post_id]

      rep = Reply.new
      rep.replydescription = replydesc
      rep.post_id =  post_id
      rep.user_id =  session[:userid]
      rep.save


      #Reply.create(replydescription: replydesc,post_id: post_id )
      @post = Post.find(post_id)
      @replies = @post.replies
      redirect_to "/replies/master/"+post_id
    else
      if !params[:id].nil?
        post_id =   params[:id]
        session[:post_id] = post_id
        @post = Post.find(post_id)
        @replies = @post.replies
        params[:id] = ""
      end
    end

    if(!session[:post_id].to_s.nil?)
      @post = Post.find(session[:post_id].to_s)
      @replies = @post.replies
    end

  end


  def voteup
    replyid = params[:id]
    replyvote = Replyvote.new
    replyvote.replyvotes_id = replyid
    replyvote.studentid = session[:studentid]
    replyvote.save
    redirect_to :controller => "replies", :action => "master"
  end

  def votedown
    replyid = params[:id]
    replyvote = Replyvote.where(["replyvotes_id = :pid and studentid = :sid", { pid: replyid, sid: session[:studentid].to_s }])
    vote_id = replyvote[0].id
    Replyvote.destroy(vote_id)
    redirect_to :controller => "replies", :action => "master"
  end

  # DELETE /replies/1
  # DELETE /replies/1.json
  def destroy
    @reply = Reply.find(params[:id])
    @reply.destroy

    respond_to do |format|
      format.html { redirect_to :controller => "replies" , :action => "master" }
      format.json { head :no_content }
    end
  end
end


