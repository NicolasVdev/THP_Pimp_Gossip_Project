class GossipLikesController < ApplicationController
  before_action :authenticate_user, only: [:create, :destroy]

  def create
  end

  def destroy
  end

  private

  def authenticate_user
    unless current_user
      flash[:alert] = "Merci de vous connecter !"
      redirect_to new_session_path
    end
  end

end
