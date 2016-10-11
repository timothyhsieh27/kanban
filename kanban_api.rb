require 'sinatra'
require 'active_record'
require_relative 'environment'
require_relative 'task'

post '/api/tasks' do
  tasks = Task.create(
    title: params['title'],
    status: params['status'],
    priority: params['priority'])
  tasks.to_json
end

get '/api/tasks' do
  title = params['title']
  status = params['status']
  priority = params['priority']

  if !title.nil?
    tasks = Task.where(title: title)
  elsif !status.nil?
    tasks = Task.where(status: status)
  elsif !priority.nil?
    tasks = Task.where(priority: priority)
  else
    tasks = Task.all.order(name: :ASC)
  end
  tasks.to_json
end

put '/api/tasks/:id' do |id|
  title = params['title']
  status = params['status']
  priority = params['priority']

  tasks = Task.find_by_id(id)
  tasks.update(title: title) unless title.nil?
  tasks.update(status: status) unless status.nil?
  tasks.update(priority: priority) unless priority.nil?

  tasks.to_json
end

delete '/api/tasks/' do
  tasks = Task.find_by(title: params['title'], status: params['status'], priority: params['priority'])
  tasks.destroy
end
