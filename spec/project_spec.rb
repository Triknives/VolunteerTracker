require "spec_helper"

describe Project do
  describe '#name' do
    it 'returns the project name' do
      project = Project.new({:name => 'Teaching Kids to Code', :id => nil})
      expect(project.name).to eq 'Teaching Kids to Code'
    end
  end

  context '#id' do
    it 'returns the id of the project before saving project' do
      project = Project.new({:name => 'Teaching Kids to Code', :id => nil})
      expect(project.id).to eq nil
    end

    it 'returns the id of the project after saving project' do
      project = Project.new({:name => 'Teaching Kids to Code', :id => nil})
      project.save
      expect(project.id).to be_an_instance_of Integer
    end
  end

  describe '#==' do
    it 'is the same project if two projects have the same name' do
      project1 = Project.new({:name => 'Teaching Kids to Code', :id => nil})
      project2 = Project.new({:name => 'Teaching Kids to Code', :id => nil})
      expect(project1 == project2).to eq true
    end
  end

  context '.all' do
    it 'is empty to start' do
      expect(Project.all).to eq []
    end

    it 'returns all projects' do
      project1 = Project.new({:name => 'Teaching Kids to Code', :id => nil})
      project1.save
      project2 = Project.new({:name => 'Teaching Ruby to Kids', :id => nil})
      project2.save
      expect(Project.all).to eq [project1, project2]
    end
  end

  describe '#save' do
    it 'saves a project to the database' do
      project = Project.new({:name => 'Teaching Kids to Code', :id => nil})
      project.save
      expect(Project.all).to eq [project]
    end
  end

  describe '.find' do
    it 'returns a project by id' do
      project1 = Project.new({:name => 'Teaching Kids to Code', :id => nil})
      project1.save
      project2 = Project.new({:name => 'Teaching Ruby to Kids', :id => nil})
      project2.save
      expect(Project.find(project1.id)).to eq project1
    end
  end

  describe '#volunteers' do
    it 'returns all volunteers for a specific project' do
      project = Project.new({:name => 'Teaching Kids to Code', :id => nil})
      project.save
      volunteer1 = Volunteer.new({:volunteer_name => 'Jasmine', :project_id => project.id, :id => nil})
      volunteer1.save
      volunteer2 = Volunteer.new({:volunteer_name => 'Joe', :project_id => project.id, :id => nil})
      volunteer2.save
      expect(project.volunteers).to eq [volunteer1, volunteer2]
    end
  end

  describe '#update' do
    it 'allows a user to update a project' do
      project = Project.new({:name => 'Teaching Kids to Code', :id => nil})
      project.save
      project.update({:name => 'Teaching Ruby to Kids', :id => nil})
      expect(project.name).to eq 'Teaching Ruby to Kids'
    end
  end

  context '#delete' do
    it 'allows a user to delete a project' do
      project = Project.new({:name => 'Teaching Kids to Code', :id => nil})
      project.save
      project.delete
      expect(Project.all).to eq []
    end
  end
end


# require ('spec_helper')
#
# describe '#Volunteer' do
#
#   before(:each) do
#     Project.clear
#     Volunteer.clear
#     @project = Project.new({:name => "Returning Veterans Project", :id => nil})
#     @project.save()
#   end
#
#   describe('#==') do
#     it("is the same volunteer if it has the same attributes as another volunteer") do
#       volunteer = Volunteer.new({:volunteer_name => "Naima", :project_id => @project.id, :id => nil})
#       volunteer2 = Volunteer.new({:volunteer_name => "Naima", :project_id => @project.id, :id => nil})
#       expect(volunteer).to(eq(volunteer2))
#     end
#   end
#
#   describe('.all') do
#     it("returns a list of all volunteers") do
#       volunteer = Volunteer.new({:volunteer_name => "Burt Macklin FBI", :project_id => @project.id, :id => nil})
#       volunteer.save()
#       volunteer2 = Volunteer.new({:volunteer_name => "lieutenant Dan", :project_id => @project.id, :id => nil})
#       volunteer2.save()
#       expect(Volunteer.all).to(eq([volunteer, volunteer2]))
#     end
#   end
#   #
#   describe('.clear') do
#     it("clears all volunteers") do
#       volunteer = Volunteer.new({:volunteer_name => "Giant Steps", :project_id => @project.id, :id => nil})
#       volunteer.save()
#       volunteer2 = Volunteer.new({:volunteer_name => "Naima", :project_id => @project.id, :id => nil})
#       volunteer2.save()
#       Volunteer.clear()
#       expect(Volunteer.all).to(eq([]))
#     end
#   end
#
#   describe('#save') do
#     it("saves a volunteer") do
#       volunteer = Volunteer.new({:volunteer_name => "Naima", :project_id => @project.id, :id => nil})
#       volunteer.save()
#       expect(Volunteer.all).to(eq([volunteer]))
#     end
#   end
#
#   describe('.find') do
#     it("finds a volunteer by id") do
#       volunteer = Volunteer.new({:volunteer_name => "Giant Steps", :project_id => @project.id, :id => nil})
#       volunteer.save()
#       volunteer2 = Volunteer.new({:volunteer_name => "Naima", :project_id => @project.id, :id => nil})
#       volunteer2.save()
#       expect(Volunteer.find(volunteer.id)).to(eq(volunteer))
#     end
#   end
#
#   describe('#update') do
#     it("updates a volunteer by id") do
#       volunteer = Volunteer.new({:volunteer_name => "Naima", :project_id => @project.id, :id => nil})
#       volunteer.save()
#       volunteer.update("Deltron", @project.id)
#       expect(volunteer.volunteer_name).to(eq("Deltron"))
#     end
#   end
#
#   describe('#delete') do
#     it("deletes all volunteers belonging to a deleted project") do
#       project = Project.new({:name => "Oregon Lifeline", :id => nil})
#       project.save()
#       volunteer = Volunteer.new({:volunteer_name => "Naima", :project_id => project.id, :id => nil})
#       volunteer.save()
#       project.delete()
#       expect(Volunteer.find(volunteer.id)).to(eq(nil))
#     end
#   end
#
#   describe('.find_by_project') do
#     it("finds volunteers for a project") do
#       project2 = Project.new({:name => "Blue", :id => nil})
#       project2.save
#       volunteer = Volunteer.new({:volunteer_name => "Naima", :project_id => @project.id, :id => nil})
#       volunteer.save()
#       volunteer2 = Volunteer.new({:volunteer_name => "California", :project_id => project2.id , :id => nil})
#       volunteer2.save()
#       expect(Volunteer.find_by_project(project2.id)).to(eq([volunteer2]))
#     end
#   end
#
#   describe('#projects') do
#     it("finds the project a volunteer belongs to") do
#       volunteer = Volunteer.new({:volunteer_name => "Naima", :project_id => @project.id, :id => nil})
#       volunteer.save()
#       expect(volunteer.projects()).to(eq(@project))
#     end
#   end
#
# end

# describe '#Project' do
#
#   describe('.all') do
#     it("returns an empty array when there are no projects") do
#       expect(Project.all).to(eq([]))
#     end
#   end
#
#   describe('#save') do
#     it("saves a new project") do
#       project = Project.new({:name => "Returning Veterans Project", :id => nil})
#       project.save()
#       project2 = Project.new({:name => "Oregon Lifeline", :id => nil})
#       project2.save()
#       expect(Project.all).to(eq([project2, project]))
#     end
#   end
# #
#   describe('.clear') do
#     it("clears all projects") do
#       project = Project.new({:name => "Returning Veterans Project", :id => nil})
#       project.save()
#       project2 = Project.new({:name => "Oregon Lifeline", :id => nil})
#       project2.save()
#       Project.clear
#       expect(Project.all).to(eq([]))
#     end
#   end
#
#   describe('#==') do
#     it("is the same project if it has the same attributes as another project") do
#       project = Project.new({:name => "Oregon Lifeline", :id => nil})
#       project2 = Project.new({:name => "Oregon Lifeline", :id => nil})
#       expect(project).to(eq(project2))
#     end
#   end
#
#   describe('.find') do
#     it("finds an project by id") do
#       project = Project.new({:name => "Returning Veterans Project", :id => nil})
#       project.save()
#       project2 = Project.new({:name => "Oregon Lifeline", :id => nil})
#       project2.save()
#       expect(Project.find(project.id)).to(eq(project))
#     end
#   end
# #
#   describe('#update') do
#     it("updates a project by id") do
#       project = Project.new({:name => "Oregon Life", :id => nil})
#       project.save()
#       project.update("Oregon Lifeline")
#       expect(project.name).to(eq("Oregon Lifeline"))
#     end
#   end
#
#   describe('#delete') do
#     it("deletes a project by id") do
#       project = Project.new({:name => "Returning Veterans Project", :id => nil})
#       project.save()
#       project2 = Project.new({:name => "Oregon Lifeline", :id => nil})
#       project2.save()
#       project.delete()
#       expect(Project.all).to(eq([project2]))
#     end
#   end
#
#   describe('#volunteers') do
#     it("returns a project's volunteers") do
#       project = Project.new({:name => "Returning Veterans Project", :id => nil})
#       project.save()
#       volunteer = Volunteer.new({:volunteer_name => "Burt Macklin FBI", :project_id => project.id, :id => nil})
#       volunteer.save()
#       volunteer2 = Volunteer.new({:volunteer_name => "lieutenant Dan", :project_id => project.id, :id => nil})
#       volunteer2.save()
#       expect(project.volunteers).to(eq([volunteer, volunteer2]))
#     end
#   end
# end
