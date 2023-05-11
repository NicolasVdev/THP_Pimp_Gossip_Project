class CitiesController < ApplicationController
  def show
    # Méthode qui récupère le potin concerné et l'envoie à la view show (show.html.erb) pour affichage
    @city = City.find(params[:id])
    @gossips = []

    @city.users.each do |user|
      @gossips += user.gossips
    end
  end
end