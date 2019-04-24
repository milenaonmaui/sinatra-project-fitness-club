class StudentsController < ApplicationController

    get '/students/login' do
        erb :'/students/login'
    end

    get '/students/show' do
        if logged_in? && !is_instructor?
            @student=current_user
            erb :'/students/show'
        else
            redirect '/students/login'
        end 
    end

    post '/students/login' do
        @student = Student.find_by(:email => params[:email])
        if @student && @student.authenticate(params[:password])
          session[:user_id] = @student.id
          session[:instructor] = false
          erb :'/students/show'
        else
          flash[:danger]="Invalid email or password"
          redirect '/students/login'
        end
    end

    get '/students/new' do
        if !logged_in?
            erb :'students/new'
        else
            flash[:info] = "You are logged in as #{current_user.email}"
            redirect to '/students/show'
        end
    end

    post '/students/new' do
        @student = Student.new(:name => params[:name], :email => params[:email], :password => params[:password])
        if  @student.save
            session[:user_id] = @student.id
            flash[:success] = "Student account created successfully!"
            redirect to '/students/show'
        else
            flash[:danger]=@student.errors.full_messages[0]
            redirect to '/students/new'
        end    
    end
end