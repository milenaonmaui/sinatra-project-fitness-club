class GroupclassController < ApplicationController

    get '/groupclasses' do
        erb :'groupclasses/index'
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