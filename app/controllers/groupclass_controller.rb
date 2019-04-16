class GroupclassController < ApplicationController

    get '/groupclasses/' do
        erb :'groupclasses/index'
    end

end