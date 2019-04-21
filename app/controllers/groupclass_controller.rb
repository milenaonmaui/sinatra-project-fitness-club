require 'rack-flash'
class GroupclassController < ApplicationController
    use Rack::Flash

    get '/groupclasses' do
        erb :'groupclasses/index'
    end

    post '/groupclasses' do
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

    get '/groupclasses/new' do
        if is_instructor?
            erb :'groupclasses/new'
        else
            flash[:message] = "You have to be logged in as an instructor to add a class"
            redirect to '/groupclasses'
        end
    end

    get '/groupclasses/:id/edit' do
        if is_instructor? 
           @groupclass= Groupclass.find_by(:id=>params[:id])
           if current_user.groupclasses.include?(@groupclass)
               erb :'/groupclasses/edit'
           end
        else
            redirect '/'
        end        
    end

    get '/groupclasses/:id/show' do
        @groupclass = Groupclass.find_by(:id=>params[:id])
        erb :'/groupclasses/show'
    end

    patch '/groupclasses/:id/signup' do
        if logged_in?
            @groupclass = Groupclass.find_by(:id=>params[:id])
            if @groupclass.students.size < @groupclass.max_students
              @groupclass.students<< current_user
              @groupclass.save
            end
            redirect to "/groupclasses/#{@groupclass.id}/show"
        else
            redirect to "/students/login"
        end 
    end

    patch '/groupclasses/:id' do  
        @groupclass = Groupclass.find_by(:id=>params[:id])
        @groupclass.name = params[:name]
        @groupclass.class_type = params[:class_type]
        @groupclass.max_students = params[:max_students]
        @groupclass.save
        redirect to "/groupclasses/#{@groupclass.id}/show"
    end

    
    
end