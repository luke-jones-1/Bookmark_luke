# frozen_string_literal: true

require 'sinatra/base'
require_relative './lib/bookmark'

# This is bigboy class
class BookmarkManager < Sinatra::Base
  get '/' do
    erb(:index)
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all

    erb(:bookmarks)
  end

  run! if app_file == $PROGRAM_NAME
end
