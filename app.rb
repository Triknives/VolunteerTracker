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
  if @album != nil
    erb(:album)
  else
    erb(:album_error)
  end
end

get ('/albums/:id/edit') do
  @album = Album.find(params[:id].to_i())
  erb(:edit_album)
end

patch ('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.update(params[:name])
  redirect to('/albums')
end

delete ('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.delete()
  redirect to('/albums')
end

get ('/albums/:id/songs/:song_id') do
  @song = Song.find(params[:song_id].to_i())
  if @song != nil
    erb(:song)
  else
    @album = Album.find(params[:id].to_i())
    erb(:album_error)
  end
end

post ('/albums/:id/songs') do
  @album = Album.find(params[:id].to_i())
  song = Song.new({:name => params[:song_name], :album_id => @album.id, :id => nil})
  song.save()
  erb(:album)
end

patch ('/albums/:id/songs/:song_id') do
  @album = Album.find(params[:id].to_i())
  song = Song.find(params[:song_id].to_i())
  song.update(params[:name], @album.id)
  erb(:album)
end

delete ('/albums/:id/songs/:song_id') do
  song = Song.find(params[:song_id].to_i())
  song.delete
  @album = Album.find(params[:id].to_i())
  erb(:album)
end

# ARTIST ROUTING:

get('/artists') do
  if params["search"]
    @artist = Artist.search(params[:search])
  elsif params["sort"]
    @artist = Artist.sort()
  else
    @artist = Artist.all
  end
  erb(:artists)
end

get ('/artists/:id') do
  @artist = Artist.find(params[:id].to_i())
  if @artist != nil
    erb(:artist)
  else
    erb(:album_error)
  end
end

get ('/artist/new') do
  erb(:new_artist)
end

post ('/artists') do
  name = params[:artist_name]
  @artist = Artist.new({:name => name, :id => nil})
  @artist.save()
  redirect to('/artists')
end

# post ('/artists/:id') do
#   name = params[:artist_name]
#   @artist = Artist.new({:name => name, :id => nil})
#   @artist.save()
#   redirect to('/artists')
# end


post ('/artists/:id') do
  name = params[:album_name]
  id = params[:id]
  @artist = Artist.find(params[:id].to_i())
  album = Album.new({:name => name, :id => id})
  album.save()
  @artist.update({:album_name => name})
  redirect to('/artists')
end


patch ('/artists/:id') do
  @artist = Artist.find(params[:id].to_i())
  @artist.update(params[:name])
  redirect to('/artists')
end

delete ('/artists/:id') do
  @artist = Artist.find(params[:id].to_i())
  @artist.delete()
  redirect to('/artists')
end
