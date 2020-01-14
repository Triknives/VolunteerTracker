require "spec_helper"

describe Volunteer do
  describe '#volunteer_name' do
    it 'returns the volunteer_name of the volunteer' do
      test_volunteer = Volunteer.new({:volunteer_name => 'Jane', :project_id => 1, :id => nil})
      expect(test_volunteer.volunteer_name).to eq 'Jane'
    end
  end

  describe '#project_id' do
    it 'returns the project_id of the volunteer' do
      test_volunteer = Volunteer.new({:volunteer_name => 'Jane', :project_id => 1, :id => nil})
      expect(test_volunteer.project_id).to eq 1
    end
  end

  describe '#==' do
    it 'checks for equality based on the volunteer_name of a volunteer' do
      volunteer1 = Volunteer.new({:volunteer_name => 'Jane', :project_id => 1, :id => nil})
      volunteer2 = Volunteer.new({:volunteer_name => 'Jane', :project_id => 1, :id => nil})
      expect(volunteer1 == volunteer2).to eq true
    end
  end

  context '.all' do
    it 'is empty to start' do
      expect(Volunteer.all).to eq []
    end

    it 'returns all volunteers' do
      volunteer1 = Volunteer.new({:volunteer_name => 'Jane', :project_id => 1, :id => nil})
      volunteer1.save
      volunteer2 = Volunteer.new({:volunteer_name => 'Joe', :project_id => 1, :id => nil})
      volunteer2.save
      expect(Volunteer.all).to eq [volunteer1, volunteer2]
    end
  end

  describe '#save' do
    it 'adds a volunteer to the database' do
      volunteer1 = Volunteer.new({:volunteer_name => 'Jane', :project_id => 1, :id => nil})
      volunteer1.save
      expect(Volunteer.all).to eq [volunteer1]
    end
  end

  describe '.find' do
    it 'returns a volunteer by id' do
      volunteer1 = Volunteer.new({:volunteer_name => 'Jane', :project_id => 1, :id => nil})
      volunteer1.save
      volunteer2 = Volunteer.new({:volunteer_name => 'Joe', :project_id => 1, :id => nil})
      volunteer2.save
      expect(Volunteer.find(volunteer1.id)).to eq volunteer1
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
#     @project = Project.new({:volunteer_name => "Returning Veterans Project", :id => nil})
#     @project.save()
#   end
#
#   describe('#==') do
#     it("is the same volunteer if it has the same attributes as another volunteer") do
#       volunteer = Volunteer.new({:volunteer_volunteer_name => "Naima", :project_id => @project.id, :id => nil})
#       volunteer2 = Volunteer.new({:volunteer_volunteer_name => "Naima", :project_id => @project.id, :id => nil})
#       expect(volunteer).to(eq(volunteer2))
#     end
#   end
#
#   describe('.all') do
#     it("returns a list of all volunteers") do
#       volunteer = Volunteer.new({:volunteer_volunteer_name => "Burt Macklin FBI", :project_id => @project.id, :id => nil})
#       volunteer.save()
#       volunteer2 = Volunteer.new({:volunteer_volunteer_name => "lieutenant Dan", :project_id => @project.id, :id => nil})
#       volunteer2.save()
#       expect(Volunteer.all).to(eq([volunteer, volunteer2]))
#     end
#   end
#   #
#   describe('.clear') do
#     it("clears all volunteers") do
#       volunteer = Volunteer.new({:volunteer_volunteer_name => "Giant Steps", :project_id => @project.id, :id => nil})
#       volunteer.save()
#       volunteer2 = Volunteer.new({:volunteer_volunteer_name => "Naima", :project_id => @project.id, :id => nil})
#       volunteer2.save()
#       Volunteer.clear()
#       expect(Volunteer.all).to(eq([]))
#     end
#   end
#
#   describe('#save') do
#     it("saves a volunteer") do
#       volunteer = Volunteer.new({:volunteer_volunteer_name => "Naima", :project_id => @project.id, :id => nil})
#       volunteer.save()
#       expect(Volunteer.all).to(eq([volunteer]))
#     end
#   end
#
#   describe('.find') do
#     it("finds a volunteer by id") do
#       volunteer = Volunteer.new({:volunteer_volunteer_name => "Giant Steps", :project_id => @project.id, :id => nil})
#       volunteer.save()
#       volunteer2 = Volunteer.new({:volunteer_volunteer_name => "Naima", :project_id => @project.id, :id => nil})
#       volunteer2.save()
#       expect(Volunteer.find(volunteer.id)).to(eq(volunteer))
#     end
#   end
#
#   describe('#update') do
#     it("updates a volunteer by id") do
#       volunteer = Volunteer.new({:volunteer_volunteer_name => "Naima", :project_id => @project.id, :id => nil})
#       volunteer.save()
#       volunteer.update("Deltron", @project.id)
#       expect(volunteer.volunteer_volunteer_name).to(eq("Deltron"))
#     end
#   end
#
#   describe('#delete') do
#     it("deletes all volunteers belonging to a deleted project") do
#       project = Project.new({:volunteer_name => "Oregon Lifeline", :id => nil})
#       project.save()
#       volunteer = Volunteer.new({:volunteer_volunteer_name => "Naima", :project_id => project.id, :id => nil})
#       volunteer.save()
#       project.delete()
#       expect(Volunteer.find(volunteer.id)).to(eq(nil))
#     end
#   end
#
#   describe('.find_by_project') do
#     it("finds volunteers for a project") do
#       project2 = Project.new({:volunteer_name => "Blue", :id => nil})
#       project2.save
#       volunteer = Volunteer.new({:volunteer_volunteer_name => "Naima", :project_id => @project.id, :id => nil})
#       volunteer.save()
#       volunteer2 = Volunteer.new({:volunteer_volunteer_name => "California", :project_id => project2.id , :id => nil})
#       volunteer2.save()
#       expect(Volunteer.find_by_project(project2.id)).to(eq([volunteer2]))
#     end
#   end
#
#   describe('#projects') do
#     it("finds the project a volunteer belongs to") do
#       volunteer = Volunteer.new({:volunteer_volunteer_name => "Naima", :project_id => @project.id, :id => nil})
#       volunteer.save()
#       expect(volunteer.projects()).to(eq(@project))
#     end
#   end
#
# end
