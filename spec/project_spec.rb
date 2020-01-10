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
    it("finds an project by id") do
      project = Project.new({:name => "Returning Veterans Project", :id => nil})
      project.save()
      project2 = Project.new({:name => "Oregon Lifeline", :id => nil})
      project2.save()
      expect(Project.find(project.id)).to(eq(project))
    end
  end
#
  describe('#update') do
    it("updates a project by id") do
      project = Project.new({:name => "Oregon Lifeline", :id => nil})
      project.save()
      project.update("Oregon Lifeline")
      expect(project.name).to(eq("Oregon Lifeline"))
    end
  end

  describe('#delete') do
    it("deletes a project by id") do
      project = Project.new({:name => "Returning Veterans Project", :id => nil})
      project.save()
      project2 = Project.new({:name => "Oregon Lifeline", :id => nil})
      project2.save()
      project.delete()
      expect(Project.all).to(eq([project2]))
    end
  end

  describe('#volunteers') do
    it("returns a project's volunteers") do
      project = Project.new({:name => "Returning Veterans Project", :id => nil})
      project.save()
      volunteer = Volunteer.new({:volunteer_name => "Burt Macklin FBI", :project_id => project.id, :id => nil})
      volunteer.save()
      volunteer2 = Volunteer.new({:volunteer_name => "lieutenant Dan", :project_id => project.id, :id => nil})
      volunteer2.save()
      expect(project.volunteers).to(eq([volunteer, volunteer2]))
    end
  end
end
