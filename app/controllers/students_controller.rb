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
          redirect '/students/login'
        end
    end

    get '/students/new' do
        if !logged_in?
            erb :'students/new'
        else
            flash[:message] = "You are logged in as #{current_user.email}"
            redirect to '/students/show'
        end
    end

    post '/students/new' do
        
        if is_instructor?
            @groupclass = Groupclass.new(params)
            @groupclass.instructor_id=current_user.id
            @groupclass.save
            redirect to "/groupclasses/#{@groupclass.id}/show"
        else
            flash[:message] = "You have to be logged in as an instructor to add a class"
            redirect to '/groupclasses'
        end
    end
end