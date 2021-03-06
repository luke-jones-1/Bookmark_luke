# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/flash'
require './lib/bookmark'
require './lib/tag'
require './lib/bookmark_tag'
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
    if Bookmark.create(url: params[:url], title: params[:title]) == false
      flash[:notice] = 'You must enter a valid URL.'
    end
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
    result =
      Bookmark.update(id: params[:id], url: params[:url], title: params[:title])
    if result == false
      flash[:notice] = 'You must enter a valid URL.'
    end
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/new_comment' do
    @bookmark_id = params[:id]
    erb :new_comment
  end

  post '/bookmarks/:id/comments' do
    Comment.create(text: params[:comment], bookmark_id: params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/new_tag' do
    @bookmark_id = params[:id]
    erb :new_tag
  end

  post '/bookmarks/:id/tags' do
    tag = Tag.create(content: params[:tag])
    BookmarkTag.create(bookmark_id: params[:id], tag_id: tag.id)
    redirect '/bookmarks'
  end

  get '/tags/:id/bookmarks' do
    @tag = Tag.find(tag_id: params[:id])
    erb :bookmarks_by_tag
  end

  run! if app_file == $PROGRAM_NAME
end
