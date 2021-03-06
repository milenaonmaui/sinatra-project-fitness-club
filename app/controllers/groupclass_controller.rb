require 'rack-flash'
class GroupclassController < ApplicationController
    use Rack::Flash

    get '/groupclasses' do
        erb :'groupclasses/index'
    end

    post '/groupclasses' do
        redirect_if_not_instructor
        
            @groupclass = Groupclass.new(params)
            @groupclass.instructor_id=current_user.id
            if @groupclass.save
                redirect to "/groupclasses/#{@groupclass.id}/show"
            else
                redirect to "/groupclasses/new"
            end
    end   

    get '/groupclasses/new' do
        redirect_if_not_instructor
        erb :'groupclasses/new'        
    end

    get '/groupclasses/:id/edit' do
        if is_instructor? 
           @groupclass= Groupclass.find_by(:id=>params[:id])
           if current_user.groupclasses.include?(@groupclass)
               erb :'/groupclasses/edit'  
           else
               redirect "/groupclasses/#{params[:id]}/show"
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
            flash[:success] = "Successfully signed up for class"
            redirect to "/groupclasses/#{@groupclass.id}/show"
        else
            redirect to "/students/login"
        end 
    end
    
    patch '/groupclasses/:id/cancel' do
        if logged_in?
            @groupclass = Groupclass.find_by(:id=>params[:id])
            @groupclass.students.delete(current_user)
            @groupclass.save
            flash[:success] = "Class cancelled successfully"
            redirect to "/groupclasses/#{@groupclass.id}/show"
        else
            redirect to "/students/login"
        end 
    end

    delete '/groupclasses/:id/delete' do  
        @groupclass = Groupclass.find_by(:id=>params[:id])
        if @groupclass && @groupclass.instructor == current_user
            @groupclass.delete
            flash[:success]="Class deleted successfully"
        else
            flash[:danger]="You have to be logged in as the class instructor to delete a class"
        end
        redirect to '/instructors'
    end

    patch '/groupclasses/:id' do  
        @groupclass = Groupclass.find_by(:id=>params[:id])
        if @groupclass && @groupclass.instructor == current_user
            @groupclass.name = params[:name]
            @groupclass.class_type = params[:class_type]
            @groupclass.max_students = params[:max_students]
            @groupclass.save
        end
        redirect to "/groupclasses/#{@groupclass.id}/show"
    end

    
    
end