class ApplicationController < Sinatra::Base

    configure do
      set :public_folder, 'public'
      set :views, 'app/views'
      enable :sessions
      set :session_secret, "password_security"
    end
    
    get '/' do
      erb :index
    end
    
    get '/login' do 
      if !logged_in?
        erb :'/login'
      else
        binding.pry
      end
    end
    get '/logout' do
      if logged_in?
        session.destroy
      end
      redirect to '/'
    end
    
    helpers do
      def logged_in?
        !!session[:user_id]
      end
  
      def current_user
        if session[:instructor]
            @current_user ||= Instructor.find_by(id: session[:user_id]) if session[:user_id]
        else
            @current_user ||= Student.find_by(id: session[:user_id]) if session[:user_id]
        end
      end
  
    end
  
  end