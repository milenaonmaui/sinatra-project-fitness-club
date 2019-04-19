class GroupclassController < ApplicationController

    get '/groupclasses' do
        erb :'groupclasses/index'
    end

    post '/groupclasses' do
        if isInstructor?
            binding.pry
            @groupclass = Groupclass.new(params)
            @groupclass.instructor_id=current_user.id
            @groupclass.save
            redirect '/groupclasses/#{@groupclass.id}/show'
        else
            redirect '/'
        end
    end

    get '/groupclasses/new' do
        if isInstructor?
            erb :'groupclasses/new'
        else
            redirect '/'
        end
    end

    get '/groupclasses/:id/edit' do

    end

    get '/groupclasses/:id/show' do
        @groupclass = Groupclass.find_by(:id=>params[:id])
        erb :'/groupclasses/show'
    end
end