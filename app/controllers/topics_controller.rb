class TopicsController < ApplicationController
  def index
    @topics = Topic.all
    #@bookmarks = Topic.bookmarks.visable_to(current_user)
    #authorize @topics
  end

  def show
    @topic = Topic.find(params[:id])
    @bookmarks = @topic.bookmarks
    #authorize @bookmarks
  end

  def new
    @topic = Topic.new
  end
  
  def create
     @topic = Topic.new(params.require(:topic).permit(:title))
     @topic.user = current_user
     if @topic.save
       flash[:notice] = "Topic saved!"
       redirect_to @topic
     else
       flash[:error] = "Error creating topic. Please try again."
       render :new
     end
   end

  def edit
    @topic = Topic.find(params[:id])
    @topic.save!
  end
  
  def update
     @topic = Topic.find(params[:id])
     if @topic.update_attributes(params.require(:topic).permit(:title))
       flash[:notice] = "Topic saved!"
       redirect_to @topic
     else
       flash[:error] = "Error saving topic. Please try again."
       render :edit
     end
  end
  
  def destroy
     @topic = Topic.find(params[:id])
 
     if @topic.destroy
       flash[:notice] = "\"#{@topic.title}\" was deleted successfully."
       redirect_to topics_path
     else
       flash[:error] = "There was an error deleting the topic."
       render :show
     end
  end
end
