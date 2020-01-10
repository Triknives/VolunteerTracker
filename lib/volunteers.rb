class Volunteer
  attr_accessor :volunteer_name, :project_id, :id

  def initialize(attributes)
    @volunteer_name = attributes.fetch(:volunteer_name)
    @project_id = attributes.fetch(:project_id)
    @id = attributes.fetch(:id)
  end

  def ==(volunteer_to_compare)
    if volunteer_to_compare != nil
      (self.volunteer_name() == volunteer_to_compare.volunteer_name()) && (self.project_id() == volunteer_to_compare.project_id())
    else
      false
    end
  end

  def self.all
    returned_volunteers = DB.exec("SELECT * FROM volunteers;")
    volunteers = []
    returned_volunteers.each() do |volunteer|
      volunteer_name = volunteer.fetch("volunteer_name")
      project_id = volunteer.fetch("project_id").to_i
      id = volunteer.fetch("id").to_i
      volunteers.push(Volunteer.new({:volunteer_name => volunteer_name, :project_id => project_id, :id => id}))
    end
    volunteers
  end

  def save
    result = DB.exec("INSERT INTO volunteers (volunteer_name, project_id) VALUES ('#{@volunteer_name}', #{@project_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def self.find(id)
    volunteer = DB.exec("SELECT * FROM volunteers WHERE id = #{id};").first
    if volunteer
      volunteer_name = volunteer.fetch("volunteer_name")
      project_id = volunteer.fetch("project_id").to_i
      id = volunteer.fetch("id").to_i
      Volunteer.new({:volunteer_name => volunteer_name, :project_id => project_id, :id => id})
    else
      nil
    end
  end

  def update(volunteer_name, project_id)
    @volunteer_name = volunteer_name
    @project_id = project_id
    DB.exec("UPDATE volunteers SET name = '#{@volunteer_name}', project_id = #{@project_id} WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM volunteers WHERE id = #{@id};")
  end

  def self.clear
    DB.exec("DELETE FROM volunteers *;")
  end

  def self.find_by_project(prj_id)
    volunteers = []
    returned_volunteers = DB.exec("SELECT * FROM volunteers WHERE project_id = #{prj_id};")
    returned_volunteers.each() do |volunteer|
      volunteer_name = volunteer.fetch("volunteer_name")
      id = volunteer.fetch("id").to_i
      volunteers.push(Volunteer.new({:volunteer_name => volunteer_name, :project_id => prj_id, :id => id}))
    end
    volunteers
  end

  def projects
    Project.find(@project_id)
  end
end
