class PokemonsController < ApplicationController
  get '/pokemons' do
    if logged_in?
      @pokemons = current_user.pokemons.all
      erb :'pokemons/index'
    else
      redirect to '/login'
    end
  end

  get '/pokemons/new' do
    if logged_in?
      erb :'pokemons/new'
    else
      redirect to '/login'
    end
  end

  post '/pokemons' do
    if logged_in?
      if params[:name] == ""
        redirect to "/pokemons/new"
      else
        @pokemon = current_user.pokemons.build(name: params[:name])
        if @pokemon.save
          redirect to "/pokemons/#{@pokemon.id}"
        else
          redirect to "/pokemons/new"
        end
      end
    else
      redirect to '/login'
    end
  end

  get '/pokemons/:id' do
    if logged_in?
      @pokemon = Pokemon.find_by_id(params[:id])
      erb :'pokemons/show'
    else
      redirect to '/login'
    end
  end

  get '/pokemons/:id/edit' do
    if logged_in?
      @pokemon = Pokemon.find_by_id(params[:id])
      if @pokemon && @pokemon.user == current_user
        erb :'pokemons/edit'
      else
        redirect to '/pokemons'
      end
    else
      redirect to '/login'
    end
  end

  patch '/pokemons/:id' do
    if logged_in?
      if params[:name] == ""
        redirect to "/pokemons/#{params[:id]}/edit"
      else
        @pokemon = Pokemon.find_by_id(params[:id])
        if @pokemon && @pokemon.user == current_user
          if @pokemon.update(name: params[:name])
            redirect to "/pokemons/#{@pokemon.id}"
          else
            redirect to "/pokemons/#{@pokemon.id}/edit"
          end
        else
          redirect to '/pokemons'
        end
      end
    else
      redirect to '/login'
    end
  end

  delete '/pokemons/:id/delete' do
    if logged_in?
      @pokemon = Pokemon.find_by_id(params[:id])
      if @pokemon && @pokemon.user == current_user
        @pokemon.delete
      end
      redirect to '/pokemons'
    else
      redirect to '/login'
    end
  end
end
