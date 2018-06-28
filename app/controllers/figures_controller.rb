class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all    #index page, shows all
    erb :'/figures/index'
  end

  get '/figures/new' do
    erb :'/figures/new'   #form for a new figure
  end

  # NEW:
  post '/figures' do
    @figure = Figure.create(params[:figure])

    if !params[:title][:name].empty?
      @figure.titles << Title.create(params[:title])
    end
    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end

    @figure.save
    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :"figures/show"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :"figures/edit"
  end

  # EDIT:
  patch "/figures/:id" do
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])

    if !params[:title][:name].empty?
      @figure.titles << Title.create(params[:title])
    end

    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end

    @figure.save
    redirect "/figures/#{@figure.id}"
  end

  delete "/figures/:id" do
    @figure = Figure.find(params[:id])
    @figure.destroy
    redirect "/figures"
  end

end


# {
#   "figure"=>{
#     "name"=>"allegra",
#     "title_ids"=>["1", "3", "4"],
#     "landmark_ids"=>["4", "5", "7"]
#   },
#  "title"=>{
#    "name"=>"the homegirl"
#  },
#  "landmark"=>{
#    "name"=>"kings cross",
#    "year_completed"=>"2018"
#    }
#  }

# figure[name]
# figure[title_ids][]
# figure[landmark_ids][]

# title[name]

# landmark[name]
# landmark[year_completed]

# {
#   "figure"=>{
#     "name"=>"Barack Obama",
#     "title_ids"=>["3"],
#     "titles"=>{"name"=>"The First Black President"},
#     "landmark_ids"=>["1", "2", "3", "4", "5", "6", "7", "8", "9"],
#     "landmarks"=>{"name"=>"The White House", "year_completed"=>"2015"}
#     }
#   }

#
# @figure = Figure.create(params[:figure])
#
# @figure.name = params[:figure][:name]
# @figure.title_ids << params[:figure][:title_ids]   # << title.id
# @figure.titles.name = params[:figure][:titles][:name]  "The First Black President"
# @figure.landmark_ids << params[:figure][:landmark_ids] # "1"
# @figure.landmarks.name = params[:figure][:landmarks][:name]  # "The White House"
# @figure.landmarks.year_completed = params[:figure][:landmarks][:year_completed] # "2015"

# if !params[:figure][:landmarks][:name].empty?
#   @figure.landmarks << Landmark.create(params[:figure][:landmarks][:name])
# end
#
# if !params[:figure][:titles][:name].empty?
#   @figure.titles << Title.create(params[:figure][:titles][:name])
# end

# {
#   "figure"=>{
#     "name"=>"Barack Obama",
#     "title_ids"=>["3"],
#     "titles"=>{
#         "name"=>"The First Black President"
#     },
#     "landmark_ids"=>["1"],
#     "landmarks"=>{
#         "name"=>"The White House",
#         "year_completed"=>"2016"
#     }
#   }
# }
# figure[name]
# figure[title_ids][]
# figure[titles][name]
# figure[landmark_ids][]
# figure[landmarks][name]
# figure[landmarks][year_completed]
