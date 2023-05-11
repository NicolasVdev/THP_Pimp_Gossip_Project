class WelcomeController < ApplicationController
  def show
    puts "Hello depuis le serveur"
    puts "#{params["first_name"]}"
    puts "C'est finni"
  end
end
