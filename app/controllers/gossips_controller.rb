class GossipsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create, :show]
  before_action :authenticate_author, only: [:edit, :update, :destroy]

  def index
    # Méthode qui récupère tous les potins et les envoie à la view index (index.html.erb) pour affichage
    @gossip = Gossip.includes(:user)
  end

  def show
    # Méthode qui récupère le potin concerné et l'envoie à la view show (show.html.erb) pour affichage
    @gossip = Gossip.find(params[:id])
  end

  def new
    # Méthode qui crée un potin vide et l'envoie à une view qui affiche le formulaire pour 'le remplir' (new.html.erb)
    @gossip = Gossip.new
  end

  def create
    # Méthode qui créé un potin à partir du contenu du formulaire de new.html.erb, soumis par l'utilisateur
    # pour info, le contenu de ce formulaire sera accessible dans le hash params (ton meilleur pote)
    # Une fois la création faite, on redirige généralement vers la méthode show (pour afficher le potin créé)
    @gossip = Gossip.new(title: params['title'], content: params['content'], user: current_user)
      if @gossip.save
      flash[:notice] = 'Le gossip a bien été créé'
      redirect_to root_path
      else
      flash[:alert] = @gossip.errors.full_messages[0]
      render 'new'
    end
  end

  def edit
    # Méthode qui récupère le potin concerné et l'envoie à la view edit (edit.html.erb) pour affichage dans un formulaire d'édition
    @gossip = Gossip.find(params[:id])
  end

  def update
    # Méthode qui met à jour le potin à partir du contenu du formulaire de edit.html.erb, soumis par l'utilisateur
    # pour info, le contenu de ce formulaire sera accessible dans le hash params
    # Une fois la modification faite, on redirige généralement vers la méthode show (pour afficher le potin modifié)
    @gossip = Gossip.find(params[:id])
    post_params = params.require(:gossip).permit(:title, :content)
    if @gossip.update(post_params)
      flash[:notice] = 'Le gossip a bien été mis à jour'
      redirect_to gossip_path
      else
      flash[:alert] = @gossip.errors.full_messages[0]
      render 'edit'
    end 
  end

  def destroy
    # Méthode qui récupère le potin concerné et le détruit en base
    # Une fois la suppression faite, on redirige généralement vers la méthode index (pour afficher la liste à jour)
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
      flash[:notice] = 'Le gossip a bien été supprimé'
    redirect_to root_path
  end

  private

  def authenticate_user
    unless current_user
      flash[:alert] = "Merci de vous connecter !"
      redirect_to new_session_path
    end
  end

  def authenticate_author
    unless current_user == Gossip.find(params[:id]).user
      flash[:alert] = "Vous n'êtes pas l'auteur !"
      redirect_to root_path
    end
  end

end