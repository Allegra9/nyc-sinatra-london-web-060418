class LandmarksController < ApplicationController

  get '/landmarks' do
    @landmarks = Landmark.all    #index page, shows all
    @figures = Figure.all    # !!!!
    erb :'/landmarks/index'
  end

  get '/landmarks/new' do
    erb :'/landmarks/new'   #form for a new landmark
  end

  # NEW:
  post "/landmarks" do
    @landmark = Landmark.create
    @landmark.name = params[:landmark][:name]
    @landmark.year_completed = params[:landmark][:year_completed]
    redirect '/landmarks'
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    erb :"landmarks/show"
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])
    erb :"landmarks/edit"
  end

  # EDIT:
  patch "/landmarks/:id" do
    @landmark = Landmark.find(params[:id])
    @landmark.update(params[:landmark])
  #updating params:
    @landmark.name = params["landmark"]["name"]
    @landmark.year_completed = params["landmark"]["year_completed"]
  #savind:
    @landmark.save
    redirect "/landmarks/#{@landmark.id}"
  end

  delete "/figures/:id" do
    @figure = Figure.find(params[:id])
    @figure.destroy
    redirect "/figures"
  end
end
