class AdminController < ApplicationController

  before_filter :authenticate, :only => [:grant_privilege,:revoke_privilege,:delete_user,:show_users ,:show_report,:show_student_profile]

  def authenticate
    if session[:userid].to_s.nil? || session[:userid].to_s.empty?
      redirect_to page_home_path , notice: "You are not authorized to view this page, Please Log in"
    else
      if session[:priority] == 0
        redirect_to page_home_path , notice: "You are not authorized to view this page"
      end
    end
  end

  def grant_privilege
    @id = params[:id]
    user = User.find(@id)
    user.priority = 1
    user.save
    redirect_to :controller => "admin" , :action => "show_users"
  end

  def revoke_privilege
    @id = params[:id]
    user = User.find(@id)
    user.priority = 0
    user.save
    redirect_to :controller => "admin" , :action => "show_users"
  end

  def delete_user
    @id = params[:id]

    @user = User.find(@id)
    @user.destroy
    redirect_to :controller => "admin" , :action => "show_users"
  end

  def show_users
    @users = User.all
  end

  def show_report
    @users = User.all
    @posts = Post.all
    @replies = Reply.all


  end

  def show_student_profile
    @users = User.all
    @posts = Post.all

  end

  def show_latest_post

    flash.now[:error] = ""
    flash.now[:notice] = ""
    valid_data = 1
    @posts = []
    days = params[:days]
    @days = days
    if params[:commit]
      if params[:commit] == "Show Report"
        if days.nil? || days.empty?
          flash.now[:error] << "Enter number of days for which the report needs to be generated<br/>"
          valid_data = 0
        end

        if valid_data = 1
          @posts = Post.where("created_at >= date('now', '-#{days} day') ")
        end
      end
    end
  end

end
