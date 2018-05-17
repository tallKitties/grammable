class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    gram_id = params[:gram_id]
    return render_error unless Gram.exists?(gram_id)

    @comment = current_user.comments.new(
        comment_params.merge(gram_id: gram_id)
      )
    if @comment.save
      redirect_to root_path(anchor: gram_id)
    else
      render_error(:unprocessable_entity)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:message)
  end
end
