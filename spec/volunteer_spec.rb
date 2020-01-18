require "spec_helper"

describe Volunteer do
  describe '#volunteer_name' do
    it 'returns the name of the volunteer' do
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
