# frozen_string_literal: true

require 'sinatra/base'

# This is bigboy class
class BookmarkManager < Sinatra::Base
  get '/' do
    erb(:index)
  end

  get '/bookmarks' do
    erb(:bookmarks)
  end

  run! if app_file == $0
end
