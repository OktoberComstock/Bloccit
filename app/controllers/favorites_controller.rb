class FavoritesController < ApplicationController
  
  def create
     post = Post.find(params[:post_id])
     favorite = current_user.favorites.build(post: post)
     
     authorize favorite
     if favorite.save
        flash[:notice] = "Favorited!"
        
       # Add code to generate a success flash and redirect to post
       # Remember the path shortcut: [post.topic, post]
     else
        flash[:error] = "There was an error favoriting. Please try again."
       # Add code to generate a failure flash and redirect to post
     end
     redirect_to [post.topic, post]
  end
  
  def destroy
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.where(post: post).first
    
   # Get the post from the params
   # Find the current user's favorite with the ID in the params
    authorize favorite
   if favorite.destroy
      flash[:notice] = "Unfavorited."  
     # Flash success and redirect to @post
   else
      flash[:error] = "Couldn't Unfavorite. Please try again."
     # Flash error and redirect to @post
     
   end
   redirect_to [post.topic, post]
  end
end