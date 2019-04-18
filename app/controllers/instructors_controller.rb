class InstructorsController < ApplicationController
  get '/instructors' do
    if logged_in? && session[:instructor]
        @instructor = current_user
        erb :'instructors/index'
    else
        erb :'/instructors/login'
    end
  end

  get '/instructors/show' do
    binding.pry
  end

  post '/instructors/login' do
    
    @instructor = Instructor.find_by(:email => params[:email])
    if @instructor && @instructor.authenticate(params[:password])
      session[:user_id] = @instructor.id
      session[:instructor] = true
      erb :'/instructors/index'
    else
      redirect '/'
    end
  end

end