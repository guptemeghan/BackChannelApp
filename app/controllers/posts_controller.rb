class PostsController < ApplicationController

  before_filter :authenticate, :only => [:index,:show,:new,:edit ,:create,:update,:destroy,:voteup,:votedown]

  def authenticate
    if session[:userid].to_s.nil? || session[:userid].to_s.empty?
      redirect_to page_home_path , notice: "You are not authorized to view this page, Please Log in"
    end
  end

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  def voteup
    postid = params[:id]
    postvote = Postvote.new
    postvote.post_id = postid
    postvote.studentid = session[:studentid]
    postvote.save
    redirect_to :controller => "posts", :action => "new"
  end

  def votedown
    postid = params[:id]
    postvote = Postvote.where(["post_id = :pid and studentid = :sid", { pid: postid, sid: session[:studentid].to_s }])
    vote_id = postvote[0].id
    Postvote.destroy(vote_id)
    redirect_to :controller => "posts", :action => "new"
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    @existingposts = Post.all
    #@existingposts.reverse!
    #@post_vote_count = 0

    post_with_count = Hash.new
    post_with_time = Hash.new

    @existingposts.each{ |post|
      post_vote_count = Postvote.where(["post_id = :pid ", { pid: post.id }]).count
      comment_count = Reply.where(["post_id = :pid ", { pid: post.id }]).count
      reply_vote_count = Replyvote.where(["replyvotes_id = :pid ", { pid: post.id }]).count
      post_with_count[post.id] = post_vote_count + comment_count + reply_vote_count

      @updated_date = post.updated_at.localtime
      @current_time = Time.new.localtime
      @hours = (@current_time - @updated_date)/(60)
      post_with_time[post.id] = @hours
    }

    result = Hash.new
    result = post_with_count.merge(post_with_time) {|key,val1,val2| val1 <= 5 ? (10000-val2)+(5*100) : (10000-val2)+(val1*100)  }
    result = result.sort {|i1,i2| i2[1] <=> i1[1]}

    @posts = []
    result.map { |post_id,value|
      @posts << Post.find(post_id)
    }
    #respond_to do |format|
    #  format.html # new.html.erb
    #  format.json { render json: @post }
    # end



  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])

    all_tags = @post.tags
    merged_tags = ""
    all_tags.each { |tag| merged_tags << tag.tagname+"," }
    @tag_post = merged_tags[0..-2]
    @postdescription = @post.postdescription
    @title = @post.title

  end

  # POST /posts
  # POST /posts.json
  def create

    @post = Post.new(params[:post])
    @post.user_id = session[:userid]
    @post.studentid = session[:studentid]
    @post.title = params[:title]
    @post.postdescription = params[:postdescription]
    session[:postid] = @post.id
    @post_tag = params[:tag]
    @posts = Post.all
    tags = @post_tag.split(",")
    respond_to do |format|
      if @post.save
        latest_post = Post.last
        latest_post_id = latest_post.id
        tags.each { |tag|
          t = Tag.new
          t.tagname = tag
          t.post_id = latest_post_id
          t.save
        }
        format.html { redirect_to new_post_url, notice: 'Post was successfully created.'}
        #format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
    @post.title = params[:title]
    @post.postdescription = params[:postdescription]

    all_tags = @post.tags
    all_tags.each { |tag| tag.destroy }

    @post_tag = params[:tag]
    tags = @post_tag.split(",")

    tags.each { |tag|
      t = Tag.new
      t.tagname = tag
      t.post_id = @post.id
      t.save
    }

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to :controller => "posts" , :action => "new" , notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    post_id = @post.id
    replies = @post.replies
    @post.destroy
    replies.each {|reply| reply.destroy}

    respond_to do |format|
      format.html { redirect_to :controller => "posts", :action=> "new" }
      format.json { head :no_content }
    end
  end
end
