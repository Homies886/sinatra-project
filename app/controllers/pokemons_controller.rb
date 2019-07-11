class PokemonController < ApplicationController

  get "/pokemon" do
    redirect_if_not_logged_in
    @pokemon = Pokemon.all
    erb :'pokemon/index'
  end

  get "/pokemon/new" do
    redirect_if_not_logged_in
    @error_message = params[:error]
    erb :'pokemon/new'
  end

  get "/pokemon/:id/edit" do
    redirect_if_not_logged_in
    @error_message = params[:error]
    @pokemon = Pokemon.find(params[:id])
    erb :'pokemon/edit'
  end

  post "/pokemon/:id" do
    redirect_if_not_logged_in
    @pokemon = Pokemon.find(params[:id])
    unless Pokemon.valid_params?(params)
      redirect "/pokemon/#{@pokemon.id}/edit?error=invalid pokemon"
    end
    @pokemon.update(params.select{|k|k=="name" || k=="capacity"})
    redirect "/pokemon/#{@pokemon.id}"
  end

  get "/pokemon/:id" do
    redirect_if_not_logged_in
    @pokemon = Pokemon.find(params[:id])
    erb :'pokemon/show'
  end

  post "/pokemon" do
    redirect_if_not_logged_in

    unless Pokemon.valid_params?(params)
      redirect "/pokemon/new?error=invalid pokemon"
    end
    Pokemon.create(params)
    redirect "/pokemon"
  end
end
