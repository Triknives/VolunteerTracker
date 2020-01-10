require 'spec_helper'

describe '#Project' do

  describe('.all') do
    it("returns an empty array when there are no projects") do
      expect(Project.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves a new project") do
      project = Project.new({:name => "Returning Veterans Project", :id => nil})
      project.save()
      project2 = Project.new({:name => "Oregon Lifeline", :id => nil})
      project2.save()
      expect(Project.all).to(eq([project2, project]))
    end
  end
#
  describe('.clear') do
    it("clears all projects") do
      project = Project.new({:name => "Returning Veterans Project", :id => nil})
      project.save()
      project2 = Project.new({:name => "Oregon Lifeline", :id => nil})
      project2.save()
      Project.clear
      expect(Project.all).to(eq([]))
    end
  end

  describe('#==') do
    it("is the same project if it has the same attributes as another project") do
      project = Project.new({:name => "Oregon Lifeline", :id => nil})
      project2 = Project.new({:name => "Oregon Lifeline", :id => nil})
      expect(project).to(eq(project2))
    end
  end

  describe('.find') do
    it("finds an album by id") do
      album = Album.new({:name => "A Love Supreme", :id => nil})
      album.save()
      album2 = Album.new({:name => "Blue", :id => nil})
      album2.save()
      expect(Album.find(album.id)).to(eq(album))
    end
  end
#
#   describe('#update') do
#     it("updates an album by id") do
#       album = Album.new({:name => "A Love Supreme", :id => nil})
#       album.save()
#       album.update("A Love Supreme")
#       expect(album.name).to(eq("A Love Supreme"))
#     end
#   end
#
#   describe('#delete') do
#     it("deletes an album by id") do
#       album = Album.new({:name => "A Love Supreme", :id => nil})
#       album.save()
#       album2 = Album.new({:name => "Blue", :id => nil})
#       album2.save()
#       album.delete()
#       expect(Album.all).to(eq([album2]))
#     end
#   end
#
#   describe('#songs') do
#     it("returns an album's songs") do
#       album = Album.new({:name => "A Love Supreme", :id => nil})
#       album.save()
#       song = Song.new({:name => "Naima", :album_id => album.id, :id => nil})
#       song.save()
#       song2 = Song.new({:name => "Cousin Mary", :album_id => album.id, :id => nil})
#       song2.save()
#       expect(album.songs).to(eq([song, song2]))
#     end
#   end
#
end
