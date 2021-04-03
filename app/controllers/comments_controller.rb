class CommentsController < ApplicationController

 def create
   if comment = Comment.create(comment_params)
     redirect_to prototype_path(comment.prototype.id)
   else
      render :edit
   end
 end



 def comment_params
  params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
end
end
