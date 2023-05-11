class GossipLikesController < ApplicationController
  before_action :authenticate_user, only: [:create, :destroy]

  def create
    @like = GossipLike.new(user: current_user, gossip_id: params[:gossip_id])
     @like.save
     redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = GossipLike.find_by(user: current_user, gossip_id: params[:gossip_id])
    @like.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def authenticate_user
    unless current_user
      flash[:alert] = "Merci de vous connecter !"
      redirect_to new_session_path
    end
  end

end
