class LikesController < ApplicationController
  def new
    @like = Like.new
  end
  
  
   def create
     @bookmark = Bookmark.find(params[:bookmark_id])
     like = current_user.likes.build(bookmark: @bookmark)
 
     if like.save
       flash[:notice] = "Bookmark liked!"
       redirect_to @bookmark.topic
     else
       flash[:error] = "Error liking bookmark. Please try again."
       redirect_to @bookmark.topic
     end
   end

   def destroy
     like = Like.find(params[:id])
     @bookmark = Bookmark.find(params[:bookmark_id])
 
     if like.destroy
       flash[:notice] = "Bookmark unliked!"
       redirect_to @bookmark.topic
     else
       flash[:error] = "There was an error unliking."
       redirect_to @bookmark.topic
     end
   end
end
