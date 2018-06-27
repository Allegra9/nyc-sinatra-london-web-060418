class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    @titles = Title.all    #loads all of the titles from the database
    @landmarks = Landmark.all   #all the landmarks
    erb :'/figures/new'
  end

  post '/figures' do   #creates new figure w selected ...
    binding.pry
    figure = Figure.create(params[:figure])
    title = Title.create(params[:title])
    landmark = Landmark.create(params[:landmark])
    figure.title_ids << title.id
    figure.landmark_ids << landmark.id

    redirect "figures/#{figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :"figures/show"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @titles = Title.all    #loads all of the titles from the database
    @landmarks = Landmark.all
    erb :"figures/edit"
  end

  patch "/figures/:id" do
    figure = Figure.find(params[:id])
    figure.update(params[:figure])
    title = Title.create(params[:title])
    landmark = Landmark.create(params[:landmark])
    figure.title_ids << title.id
    figure.landmark_ids << landmark.id
    redirect "/figures/#{figure.id}"
  end

  delete "/figures/:id" do
    @figure = Figure.find(params[:id])
    @figure.destroy
    redirect "/figures"
  end

end
