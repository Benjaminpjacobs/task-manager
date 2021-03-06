require_relative "../models/task.rb"

class TaskManagerApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)

  get '/' do
    erb :dashboard
  end

  get '/tasks' do 
    @tasks = Task.all
    erb :index
  end

  get '/tasks/new' do
    erb :new
  end

  get '/tasks/:id' do
    @task = Task.find(params[:id])
    erb :show
  end
  
  post '/tasks' do
    task = Task.new(params[:task])
    task.save
    redirect '/tasks'
  end

  get '/delete/:id' do
    Task.delete(params[:id])
    erb :confirm_delete
  end

  get '/update/:id' do
    @task = Task.find(params[:id])
    erb :update
  end

  post '/update/:id' do
    Task.update_title(params[:title], params[:id]) unless 
    params[:title].empty?
    Task.update_description(params[:description], params[:id]) unless 
    params[:description].empty?
    @tasks = Task.all
    erb :index
  end

  
end