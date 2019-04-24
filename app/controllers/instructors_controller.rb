class InstructorsController < ApplicationController
  get '/instructors' do
    if logged_in? && session[:instructor]
        @instructor = current_user
        erb :'instructors/show'
    else
        erb :'/instructors/index'
    end
  end

  get '/instructors/:id/show' do
    @instructor = Instructor.find_by(:id=>params[:id])
    erb :'/instructors/show'
  end

  post '/instructors/login' do
    
    @instructor = Instructor.find_by(:email => params[:email])
    if @instructor && @instructor.authenticate(params[:password])
      session[:user_id] = @instructor.id
      session[:instructor] = true
      erb :'/instructors/show'
    else
      flash[:danger] = "Invalid email or password"
      redirect '/instructors'
    end
  end

end