require ('spec_helper')

describe '#Volunteer' do

  before(:each) do
    Project.clear
    Volunteer.clear
    @project = Project.new({:name => "Returning Veterans Project", :id => nil})
    @project.save()
  end

  describe('#==') do
    it("is the same volunteer if it has the same attributes as another volunteer") do
      volunteer = Volunteer.new({:volunteer_name => "Naima", :project_id => @project.id, :id => nil})
      volunteer2 = Volunteer.new({:volunteer_name => "Naima", :project_id => @project.id, :id => nil})
      expect(volunteer).to(eq(volunteer2))
    end
  end

  describe('.all') do
    it("returns a list of all volunteers") do
      volunteer = Volunteer.new({:volunteer_name => "Burt Macklin FBI", :project_id => @project.id, :id => nil})
      volunteer.save()
      volunteer2 = Volunteer.new({:volunteer_name => "lieutenant Dan", :project_id => @project.id, :id => nil})
      volunteer2.save()
      expect(Volunteer.all).to(eq([volunteer, volunteer2]))
    end
  end
  #
  describe('.clear') do
    it("clears all volunteers") do
      volunteer = Volunteer.new({:volunteer_name => "Giant Steps", :project_id => @project.id, :id => nil})
      volunteer.save()
      volunteer2 = Volunteer.new({:volunteer_name => "Naima", :project_id => @project.id, :id => nil})
      volunteer2.save()
      Volunteer.clear()
      expect(Volunteer.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves a volunteer") do
      volunteer = Volunteer.new({:volunteer_name => "Naima", :project_id => @project.id, :id => nil})
      volunteer.save()
      expect(Volunteer.all).to(eq([volunteer]))
    end
  end
  
  describe('.find') do
    it("finds a song by id") do
      song = Song.new({:name => "Giant Steps", :album_id => @album.id, :id => nil})
      song.save()
      song2 = Song.new({:name => "Naima", :album_id => @album.id, :id => nil})
      song2.save()
      expect(Song.find(song.id)).to(eq(song))
    end
  end
  #
  # describe('#update') do
  #   it("updates an song by id") do
  #     song = Song.new({:name => "Naima", :album_id => @album.id, :id => nil})
  #     song.save()
  #     song.update("Mr. P.C.", @album.id)
  #     expect(song.name).to(eq("Mr. P.C."))
  #   end
  # end
  #
  # describe('#delete') do
  #   it("deletes all songs belonging to a deleted album") do
  #     album = Album.new({:name => "A Love Supreme", :id => nil})
  #     album.save()
  #     song = Song.new({:name => "Naima", :album_id => album.id, :id => nil})
  #     song.save()
  #     album.delete()
  #     expect(Song.find(song.id)).to(eq(nil))
  #   end
  # end
  #
  # describe('.find_by_album') do
  #   it("finds songs for an album") do
  #     album2 = Album.new({:name => "Blue", :id => nil})
  #     album2.save
  #     song = Song.new({:name => "Naima", :album_id => @album.id, :id => nil})
  #     song.save()
  #     song2 = Song.new({:name => "California", :album_id => album2.id , :id => nil})
  #     song2.save()
  #     expect(Song.find_by_album(album2.id)).to(eq([song2]))
  #   end
  # end
  #
  # describe('#album') do
  #   it("finds the album a song belongs to") do
  #     song = Song.new({:name => "Naima", :album_id => @album.id, :id => nil})
  #     song.save()
  #     expect(song.album()).to(eq(@album))
  #   end
  # end

end
