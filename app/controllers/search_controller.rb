class SearchController < ApplicationController
  def search_by


    @uname=params[:uname]
    @search= params[:search]
    @category = params[:category]
    @content =params[:cont]
    @tag = params[:t]
    @user_posts = []

    if @search == "username"
      #check whether username is entered or not
      if @uname.nil? || @uname.empty?
        flash.now[:error] = "Please enter a username <br/>"
      else
        @uname.strip!
        user = User.where("UPPER(username) LIKE UPPER('%#{@uname}%') or UPPER(studentid) LIKE UPPER('%#{@uname}%') or UPPER(email) LIKE UPPER('%#{@uname}%')")

        if user.count == 0
          flash.now[:notice] = "User doesn't exist"
        else
          @user_posts = user[0].posts

          if @user_posts.count == 0
            flash.now[:notice] = "User has not posted any questions"
          else
            post_with_count = Hash.new
            post_with_time = Hash.new

            @user_posts.each{ |post|
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

            @user_posts = []
            result.map { |post_id,value|
              @user_posts << Post.find(post_id)
            }
            @content = ""
            @tag = ""
          end
        end
      end
    elsif @search == "category"
      category = Category.where(:id => @category)

      @user_posts = category[0].posts

      if @user_posts.count == 0
        flash.now[:notice] = "No posts were found under this category"
      else

        post_with_count = Hash.new
        post_with_time = Hash.new

        @user_posts.each{ |post|
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

        @user_posts = []
        result.map { |post_id,value|
          @user_posts << Post.find(post_id)
        }
      end

      @content = ""
      @tag = ""
      @uname = ""
    elsif @search == "content"
      if @content.nil? || @content.empty?
        flash.now[:notice] = "Enter the content to be searched"
      else
        @content.strip!
        @user_posts =  Post.where("UPPER(postdescription) LIKE UPPER('%#{@content}%') OR UPPER(title) LIKE UPPER('%#{@content}%')")

        if @user_posts.count == 0
          flash.now[:notice] = %Q{No posts match with the content '#{@content}'}
        else


          post_with_count = Hash.new
          post_with_time = Hash.new

          @user_posts.each{ |post|
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

          @user_posts = []
          result.map { |post_id,value|
            @user_posts << Post.find(post_id)
          }

        end
      end
      @tag = ""
      @uname = ""
    elsif @search == "tag"
      if @tag.nil? || @tag.empty?
        flash.now[:notice] = "Enter a tag to search"
      else
        @tag.strip!
        tags = Tag.where("UPPER(tagname) LIKE UPPER('%#{@tag}%')")
        tags.each{|tag| @user_posts << tag.post }

        if @user_posts.count == 0
          flash.now[:notice] = %Q{No posts are associated with tag '#{@tag}'}
        else

          post_with_count = Hash.new
          post_with_time = Hash.new

          @user_posts.each{ |post|
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

          @user_posts = []
          result.map { |post_id,value|
            @user_posts << Post.find(post_id)
          }

        end
      end
      @content = ""
      @uname = ""
    end
  end
end