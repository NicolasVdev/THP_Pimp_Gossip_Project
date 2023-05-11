class CommentsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create]

  def create
    @comment = Comment.new(content: params['content'], user: current_user, gossip_id: params[:gossip_id] )
     @comment.save
      flash[:notice] = 'ton commentaire a bien été ajouté'
      redirect_to gossip_path(params[:gossip_id])
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @path = Gossip.find_by(id:@comment.gossip_id)
    post_params = params.require(:comment).permit(:content)
    @comment.update(post_params)
      flash[:notice] = 'Le commentaire a bien été mis à jour'
      redirect_to @path
  end

  def destroy
    @comment = Comment.find(params[:id])
    @path = Gossip.find_by(id:@comment.gossip_id)
    @comment.destroy
      flash[:notice] = 'Le commentaire a bien été supprimé'
      redirect_to @path
  end

  private

  def authenticate_user
    unless current_user
      flash[:alert] = "Merci de vous connecter !"
      redirect_to new_session_path
    end
  end

end