# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/flash'
require './lib/bookmark'
require './database_connection_setup'
require 'uri'

# This is bigboy class
class BookmarkManager < Sinatra::Base
  enable :sessions, :method_override
  register Sinatra::Flash

  get '/' do
    erb(:index)
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all

    erb(:bookmarks)
  end

  get '/new' do
    erb(:new)
  end

  post '/bookmarks' do
    flash[:notice] = "You must enter a valid URL." unless Bookmark.create(url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/edit' do
    @bookmark = Bookmark.find(id: params[:id])
    erb(:edit)
  end

  patch '/bookmarks/:id' do
    flash[:notice] = "You must enter a valid URL." unless Bookmark.update(id: params[:id], url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/new_comment' do
    @bookmark_id = params[:id]
    erb :'new_comment'
  end

  post '/bookmarks/:id/comments' do
    Comment.create(text: params[:comment], bookmark_id: params[:id])
    redirect '/bookmarks'
  end

  run! if app_file == $PROGRAM_NAME
end
