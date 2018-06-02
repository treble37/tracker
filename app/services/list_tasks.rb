class ListTasks < ListCollection

  attr_defaultable :tasks, -> { project.tasks }
  attr_defaultable :result_serializer, -> { V1::TaskSerializer }

  def initialize(page: 1, page_size: 25, project_id:)
    @project = Project.find_by(id: project_id)
    super(page: page, page_size: page_size)
  end

  def project
    @project
  end

  def collection_type
    :tasks
  end

  def collection
    tasks
  end

end
