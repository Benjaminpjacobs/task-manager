require 'sqlite3'

class Task
  attr_reader :title, :description, :id
  def initialize(task_params)
    @description = task_params["description"]
    @title       = task_params["title"]
    @database = SQLite3::Database.new('db/task_manager_development.db')
    @database.results_as_hash = true
    @id = task_params["id"] if task_params["id"]
  end
  
  def save
    @database.execute("INSERT INTO tasks (title, description) VALUES(?, ?);", @title, @description)
  end

  def self.all
    tasks = database.execute("SELECT * FROM tasks")
    tasks.map do |task|
      Task.new(task)
    end
  end

  def self.find(id)
    task = database.execute("SELECT * FROM tasks WHERE id= ?;", id).first
    Task.new(task)
  end

  def self.delete(id)
    database.execute("DELETE FROM tasks WHERE id= ?;", id)
  end

  def self.update_description(description, id)
    database.execute("UPDATE tasks SET DESCRIPTION= ? WHERE id= ?", description, id)
  end

  def self.update_title(title, id)
    database.execute("UPDATE tasks SET Title= ? WHERE id= ?", title, id)
  end

  def self.database
    database = SQLite3::Database.new('db/task_manager_development.db')
    database.results_as_hash = true
    database
  end
end
