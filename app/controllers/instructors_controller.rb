class InstructorsController < ApplicationController
  get '/instructors' do
    erb :'instructors/login'
  end

  post '/instructors/show' do
    binding.pry
  end

  post '/instructors/login' do
    
    @instructor = Instructor.find_by(:email => params[:email])
    if @instructor && @instructor.authenticate(params[:password])
      session[:user_id] = @instructor.id
      erb :'/instructors/index'
    else
      redirect '/'
    end
  end

end