class StudentsController < ApplicationController

    get '/students/login' do
        erb :'/students/login'
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
end