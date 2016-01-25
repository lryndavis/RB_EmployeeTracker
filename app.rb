require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'
also_reload('./**/*.rb')
require 'pg'
require './lib/division'
require './lib/employee'
require './lib/project'
require "pry"

get '/' do
  @employees = Employee.all
  @divisions = Division.all
  @projects = Project.all
  erb :index
end

get '/employees/:id' do
  id = params[:id].to_i
  @divisions = Division.all
  @projects = Project.all
  @employee = Employee.find(id)
  if @employee.division_id
    @division = Division.find(@employee.division_id)
  end
  if @employee.project_id
    @project = Project.find(@employee.project_id)
  end
  erb :employee
end

post '/employees/new' do
  name = params[:employee_name]
  Employee.create({name: name})
  redirect '/'
end

patch '/employees/:id/update' do
  id = params[:id].to_i
  division = params[:division]
  project = params[:project]
  @employee = Employee.find(id)
  if !params[:employee_name].empty?
    name = params[:employee_name]
  else
    name = @employee.name
  end
  @employee.update({name: name, division_id: division, project_id: project})
  redirect "/employees/#{id}"
end

delete '/employees/:id/delete' do
  id = params[:id].to_i
  Employee.delete(id)
  redirect '/'
end

post '/divisions/new' do
  name = params[:division_name]
  Division.create({name: name})
  redirect '/'
end

get '/divisions/:id' do
  id = params[:id].to_i
  @division = Division.find(id)
  @employees = @division.employees()
  erb :division
end

patch '/divisions/:id/update' do
  id = params[:id].to_i
  name = params[:project_name]
  @project = Division.find(id)
  @project.update({name: name})
  erb :project
end

delete '/diivisions/:id/delete' do
  id = params[:id].to_i
  Division.delete(id)
  redirect '/'
end

post '/projects/new' do
  name = params[:project_name]
  Project.create({name: name})
  redirect '/'
end

get '/projects/:id' do
  id = params[:id].to_i
  @project = Project.find(id)
  @employees = @project.employees()
  @available_employees = Employee.all
  erb :project
end

patch '/projects/:id/update' do
  id = params[:id].to_i
  name = params[:project_name]
  @project = Project.find(id)
  @project.update({name: name})
  erb :project
end

delete '/projects/:id/delete' do
  id = params[:id].to_i
  Project.delete(id)
  redirect '/'
end

post '/projects/:id/add_employee' do
  employee = Employee.find(params[:employee_id].to_i)
  employee.update({project_id: params[:id].to_i})
  redirect "/projects/#{params[:id].to_i}"
end
