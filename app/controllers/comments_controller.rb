class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @comment = Comment.new(comment_params)
    @comment.save
  end

  private
    def comment_params
      params.require(:comment).permit(:text)
        .merge(user_id: current_user.id, post_id: params[:id])
    end
end
