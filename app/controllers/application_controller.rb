class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do
    erb :index
  end
 
  get '/recipes/new' do
    erb :new
  end 

  post '/recipes' do
    @recipe=Recipe.create(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time].to_i)
    redirect "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id' do
    @recipe = Recipe.find_by(:id => params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by(:id => params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    @recipe=Recipe.find_by(:id => params[:id])
    @recipe.name=params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    
    redirect "/recipes/#{@recipe.id}"
  end

  delete "/recipes/:id" do
    Recipe.destroy(params[:id])
    redirect to "/recipes"
  end
end
