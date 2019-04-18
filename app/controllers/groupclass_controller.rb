class GroupclassController < ApplicationController

    get '/groupclasses' do
        erb :'groupclasses/index'
    end

    get '/groupclasses/:id/show' do
        @groupclass = Groupclass.find_by(:id=>params[:id])
        erb :'/groupclasses/show'
    end
end