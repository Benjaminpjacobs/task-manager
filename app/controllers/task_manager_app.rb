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

  get '/delete/:id' do
    Task.delete(params[:id])
    erb :confirm_delete
  end

  get '/delete' do
    @tasks = Task.all
    erb :delete_menu
  end

  post '/tasks' do
    task = Task.new(params[:task])
    task.save
    redirect '/tasks'
  end
  
end