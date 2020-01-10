class Project
  attr_accessor :name, :id


  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all
    returned_projects = DB.exec("SELECT * FROM projects;")
    projects = []
    returned_projects.each() do |project|
      name = project.fetch("name")
      id = project.fetch("id").to_i
      projects.push(Project.new({:name => name, :id => id}))
    end
    projects.sort_by { |project| [project.name] }
  end

  def self.search(query)
    returned_projects = DB.exec("SELECT * FROM projects WHERE name LIKE '%#{query}%';")
    projects = []
    returned_projects.each() do |project|
      name = project.fetch("name")
      id = project.fetch("id").to_i
      projects.push(Project.new({:name => name, :id => id}))
    end
    projects.sort_by { |project| [project.name] }
  end



  def save
    result = DB.exec("INSERT INTO projects (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(project_to_compare)
    if project_to_compare != nil
      self.name() == project_to_compare.name()
    else
      false
    end
  end

  def self.clear
    DB.exec("DELETE FROM projects *;")
  end

  def self.find(id)
    album = DB.exec("SELECT * FROM projects WHERE id = #{id};").first
    if project
      name = project.fetch("name")
      id = project.fetch("id").to_i
      Project.new({:name => name, :id => id})
    else
      nil
    end
  end

  def update(name)
    @name = name
    DB.exec("UPDATE projects SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM projects WHERE id = #{@id};")
    DB.exec("DELETE FROM volunteers WHERE project_id = #{@id};")
  end

  def volunteers
    Volunteer.find_by_project(self.id)
  end
end
