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
    it("finds a volunteer by id") do
      volunteer = Volunteer.new({:volunteer_name => "Giant Steps", :project_id => @project.id, :id => nil})
      volunteer.save()
      volunteer2 = Volunteer.new({:volunteer_name => "Naima", :project_id => @project.id, :id => nil})
      volunteer2.save()
      expect(Volunteer.find(volunteer.id)).to(eq(volunteer))
    end
  end

  describe('#update') do
    it("updates a volunteer by id") do
      volunteer = Volunteer.new({:volunteer_name => "Naima", :project_id => @project.id, :id => nil})
      volunteer.save()
      volunteer.update("Deltron", @project.id)
      expect(volunteer.volunteer_name).to(eq("Deltron"))
    end
  end

  describe('#delete') do
    it("deletes all volunteers belonging to a deleted project") do
      project = Project.new({:name => "Oregon Lifeline", :id => nil})
      project.save()
      volunteer = Volunteer.new({:volunteer_name => "Naima", :project_id => project.id, :id => nil})
      volunteer.save()
      project.delete()
      expect(Volunteer.find(volunteer.id)).to(eq(nil))
    end
  end

  describe('.find_by_project') do
    it("finds volunteers for a project") do
      project2 = Project.new({:name => "Blue", :id => nil})
      project2.save
      volunteer = Volunteer.new({:volunteer_name => "Naima", :project_id => @project.id, :id => nil})
      volunteer.save()
      volunteer2 = Volunteer.new({:volunteer_name => "California", :project_id => project2.id , :id => nil})
      volunteer2.save()
      expect(Volunteer.find_by_project(project2.id)).to(eq([volunteer2]))
    end
  end

  describe('#projects') do
    it("finds the project a volunteer belongs to") do
      volunteer = Volunteer.new({:volunteer_name => "Naima", :project_id => @project.id, :id => nil})
      volunteer.save()
      expect(volunteer.projects()).to(eq(@project))
    end
  end

end
