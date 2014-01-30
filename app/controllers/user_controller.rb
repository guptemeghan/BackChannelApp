class UserController < ApplicationController

  before_filter :authenticate, :only => [:edit_profile]
  before_filter :authenticateDelete, :only => [:delete_account]

  def authenticate
    if session[:userid].to_s.nil? || session[:userid].to_s.empty?
      redirect_to page_home_path , notice: "You are not authorized to view this page, Please Log in"
    end
  end

  def authenticateDelete
    if session[:userid].to_s.nil? || session[:userid].to_s.empty?
      redirect_to page_home_path , notice: "You are not authorized to view this page, Please Log in"
    else
      if session[:priority] == 2
        redirect_to page_home_path , notice: "This is a superadmin account, it cannot be deleted"
      end
    end
  end

  def delete_account
    current_user = User.find(session[:userid].to_s)
    current_user.destroy
    session[:username] = ""
    session[:userid] = ""
    session[:studentid] = ""
    redirect_to  page_home_path, notice: "Successfully deleted account"
  end


  def edit_profile
    flash.now[:error] = ""
    flash.now[:notice] = ""


    if params[:commit] == "Update Name"
      edit_name =  params[:edit_name]
      @edit_name =  edit_name
      updateflag = 1

      #check whether Full name is entered or not
      if edit_name.nil? || edit_name.empty?
        flash.now[:error] << "Full Name cannot be blank<br/>"
        updateflag = 0
      end

      if updateflag != 0
        user = User.find(session[:userid].to_s)
        user.update_attributes(:name => edit_name)
        user = User.where(:id => session[:userid].to_s)
        @edit_name = user[0].name
        @edit_email = user[0].email
        flash.now[:notice] << "Successfuly updated Name <br/>"
      end

    elsif params[:commit] == "Update Email"

      edit_email = params[:edit_email]
      @edit_email = edit_email

      updateflag = 1

      #check whether email address is entered or not
      if edit_email.nil? || edit_email.empty?
        flash.now[:error] << "Email address cannot be blank<br/>"
        updateflag = 0
      end


      current_user = session[:userid].to_s
      users = User.all
      users.each {|user|

        if(user.email == edit_email && current_user != user.id)
          flash.now[:error] << "An account already exists with this email address<br/>"
          user = User.where(:id => session[:userid].to_s)
          @edit_email = user[0].email
          updateflag = 0
          break
        end
      }

      if updateflag != 0
        user = User.find(session[:userid].to_s)
        user.update_attributes(:email => edit_email)
        user = User.where(:id => session[:userid].to_s)
        @edit_name = user[0].name
        @edit_email = user[0].email
        flash.now[:notice] << "Successfuly updated email address <br/>"
      end

    elsif params[:commit] == "Change password"

      edit_password = params[:edit_password].to_s
      edit_confirm_password =   params[:edit_confirm_password]
      updatepassword = 1

      #check whether Password is entered or not
      if edit_password.nil? || edit_password.empty?
        flash.now[:error] << "Password cannot be blank<br/>"
        updatepassword = 0
      end

      #check whether confirmation password is entered or not
      if edit_confirm_password.nil? || edit_confirm_password.empty?
        flash.now[:error] << "Confirmation Password cannot be blank<br/>"
        updatepassword = 0
      end

      #check whether password and retype password are same
      if edit_password != edit_confirm_password
        flash.now[:error] << "Password and Confirmation password do not match<br/>"
        updatepassword = 0
      end

      if updatepassword != 0
        user = User.find(session[:userid].to_s)
        @edit_name = user.name
        @edit_email = user.email
        user.update_attributes(:password => edit_password)
        flash.now[:notice] << "Successfuly changed password<br/>"
      end

    else
      user = User.where(:id => session[:userid].to_s)
      @edit_name = user[0].name
      @edit_email = user[0].email

    end

  end

end
