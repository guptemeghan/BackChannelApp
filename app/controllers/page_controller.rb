class PageController < ApplicationController

  def contact_us
  end

  def home

  end

  def login

    flash.now[:error] = ""
    flash.now[:notice] = ""

    #Login condition check

    if params[:commit]

      if params[:commit] == "Login"
        username = params[:login_username]
        password = params[:login_password]


        valid_data = 1

        #check whether username is entered or not
        if username.nil? || username.empty?
          flash.now[:error] << "Username cannot be blank<br/>"
          valid_data = 0
        end

        #check whether password is entered or not
        if password.nil? || password.empty?
          flash.now[:error] << "Password cannot be blank<br/>"
          valid_data = 0
        end

        @login_username = username
        @login_password = password


        if(valid_data == 1)
          existing_users = User.find_all_by_username(username)

          if existing_users.count == 1
            existing_user = existing_users[0]
            exist_pass = existing_users[0].password

            if exist_pass  == @login_password
              flash.now[:notice] << "Successfully logged in<br/>"
              session[:username]=@login_username
              session[:userid] = existing_user.id
              session[:studentid] = existing_user.studentid
              session[:priority] = existing_user.priority
              redirect_to page_home_path, notice: "Successfully Logged in"
            else
              flash.now[:error] << "Invalid Password<br/>"
            end
          else
            flash.now[:error] << "Username does not exist<br/>"
          end
        end
      end

      #Creating a new account
      if params[:commit] == "Create User"

        name =  params[:create_name]
        username = params[:create_username]
        password = params[:create_password].to_s
        confirm_password =   params[:create_confirm_password]
        email = params[:create_email]
        student_id = params[:create_student_id]

        @create_name =  name
        @create_username = username
        @create_email = email
        @create_student_id = student_id
        create_flag = 1


        #check whether Full name is entered or not
        if name.nil? || name.empty?
          flash.now[:error] << "Full Name cannot be blank<br/>"
          create_flag = 0
        end

        #check whether email address is entered or not
        if email.nil? || email.empty?
          flash.now[:error] << "Email address cannot be blank<br/>"
          create_flag = 0
        end

        #check whether student_id is entered or not
        if student_id.nil? || student_id.empty?
          flash.now[:error] << "Student Id cannot be blank<br/>"
          create_flag = 0
        end

        #check whether user name is entered or not
        if username.nil? || username.empty?
          flash.now[:error] << "Username cannot be blank<br/>"
          create_flag = 0
        end

        #check whether Full name is entered or not
        if password.nil? || password.empty?
          flash.now[:error] << "Password cannot be blank<br/>"
          create_flag = 0
        end

        #check whether confirmation password is entered or not
        if confirm_password.nil? || confirm_password.empty?
          flash.now[:error] << "Confirmation Password cannot be blank<br/>"
          create_flag = 0
        end


        if User.all.count != 0

          users = User.all
          users.each {|user|

            if(user.username == username)
              flash.now[:error] << "Username already exists<br/>"
              @username = ""
              create_flag = 0
              break
            end
            if(user.studentid == student_id)
              flash.now[:error] << "An account already exists with this Student Id<br/>"
              @create_student_id = ""
              create_flag = 0
              break
            end
            if(user.email == email)
              flash.now[:error] << "An account already exists with this email address<br/>"
              @create_email = ""
              create_flag = 0
              break
            end
          }

          #check whether password and retype password are same
          if confirm_password != password
            flash.now[:error] << "Password and Confirmation password do not match<br/>"
            create_flag = 0
          end


          if create_flag != 0
          User.create(name: name,username: username,password: password, email: email,studentid: @create_student_id,priority: 0)
            @username = username
            @name = name

            flash.now[:notice] << "Account successfully created. You can now login<br/>"
            @create_name =  ""
            @create_username = ""
            @create_email = ""
            @create_student_id = ""
          end
        else
          #check whether password and retype password are same
          if confirm_password != password
            flash.now[:error] << "Password and Confirmation password do not match<br/>"
            create_flag = 0
          else


            User.create(name: name,username: username,password: password, email: email,studentid: @create_student_id,priority: 0)
            @username = username
            @name = name
            flash.now[:notice] << "Account successfully created. You can now login<br/>"
          end

        end

      end
    end
  end



  def logout
    session[:username]= ""
    session[:userid] = ""
    session[:studentid] = ""
    session[:priority] = ""
    redirect_to page_home_path , notice: "Successfully Logged Out"
  end

  def view_posts

  end
      def routing_error
        p "routing error path: #{params[:path]}"
  end
end
