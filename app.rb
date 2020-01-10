require('sinatra')
require('sinatra/reloader')
require('./lib/project')
require('./lib/volunteers')
require('pry')
require ('pg')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "volunteer_tracker"})

get('/') do
  redirect to('/projects')
end

# PROJECT ROUTING:

get('/') do
  if params["search"]
    @projects = Project.search(params[:search])
  elsif params["sort"]
    @projects = Project.sort()
  else
    @projects = Project.all
  end
  erb(:projects)
end

get ('/projects/new') do
  erb(:new_project)
end

post ('/projects') do
  name = params[:name]
  project = Project.new({:name => name, :id => nil})
  project.save()
  redirect to('/projects')
end

get ('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  if @project != nil
    erb(:project)
  else
    erb(:project_error)
  end
end

get ('/projects/:id/edit') do
  @project = Project.find(params[:id].to_i())
  erb(:edit_project)
end

patch ('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  @project.update(params[:name])
  redirect to('/projects')
end

delete ('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  @project.delete()
  redirect to('/projects')
end

get ('/projects/:id/volunteers/:volunteer_id') do
  @volunteer= Volunteer.find(params[:volunteer_id].to_i())
  if @volunteer != nil
    erb(:volunteer)
  else
    @project = Project.find(params[:id].to_i())
    erb(:project_error)
  end
end

post ('/projects/:id/volunteers') do
  @project = Project.find(params[:id].to_i())
  volunteer = Volunteer.new({:name => params[:volunteer_name], :project_id => @project.id, :id => nil})
  volunteer.save()
  erb(:project)
end

patch ('/projects/:id/volunteers/:volunteer_id') do
  @project = Project.find(params[:id].to_i())
  volunteer = Volunteer.find(params[:volunteer_id].to_i())
  volunteer.update(params[:volunteer_name], @project.id)
  erb(:project)
end

delete ('/projects/:id/volunteers/:volunteer_id') do
  volunteer = Volunteer.find(params[:volunteer_id].to_i())
  volunteer.delete
  @project = Project.find(params[:id].to_i())
  erb(:project)
end
