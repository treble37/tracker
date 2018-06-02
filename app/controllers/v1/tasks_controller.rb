module V1
  class TasksController < ApplicationController
    swagger_controller :tasks, 'Tasks'

    swagger_api :index do
      summary 'List all tasks'
      notes 'This lists all the active tasks'
      param :path, :project_id, :string, :required, 'Project Id'
      param :query, :page, :integer, :optional, 'page number of results, default 1'
      param :query, :page_size, :integer, :optional, 'number of results per page, default 25'
    end
    def index
      tasks, errors = ListTasks.new(index_params).call
      if errors.any?
        render json: { errors: errors }, status: 400
      else
        render json: tasks
      end
    end

    swagger_api :show do
      summary 'Fetch a single Task'
      param :path, :project_id, :string, :required, 'Project Id'
      param :path, :id, :string, :required, 'Task Id'
    end
    def show
      task = Task.find_by id: params[:id]
      if task.present?
        render json: task
      else
        render json: { errors: ['Task not found'] }, status: 404
      end
    end

    swagger_api :create do
      summary 'Creates a new Task or Tasks'
      param :path, :project_id, :string, :required, 'Project Id'
      param :form, :name, :string, :optional, 'Task name'
      param :form, :description, :string, :optional, 'Task description'
      param :form, :state, :string, :optional, 'Task state'
    end
    def create
      project = Project.find_by id: params[:project_id]
      task = project.present? ? project.tasks.create(task_params) : nil
      if project.present? && task.present?
        render json: task, status: 201
      else
        render json: { errors: ['Unable to create task'] }, status: 400
      end
    end

    swagger_api :update do
      summary 'Updates an existing Task or Tasks'
      param :path, :project_id, :string, :required, 'Project Id'
      param :path, :id, :string, :required, 'Task Id'
      param :form, :name, :string, :optional, 'Task name'
      param :form, :description, :string, :optional, 'Task description'
      param :form, :state, :string, :optional, 'Task state'
    end

    def update
      task = Task.find_by(project_id: params[:project_id], id: params[:id])
      if task.present? && task.update_attributes(task_params)
        render json: task
      elsif task.present?
        render json: { errors: task.errors.full_messages }, status: 400
      else
        render json: { errors: ['Task not found'] }, status: 404
      end
    end

    swagger_api :bulk_update do
      summary 'Updates an existing Task or Tasks'
      param :path, :project_id, :string, :required, 'Project Id'
      param :path, :id, :string, :required, 'Task Id'
      param :form, :project, :tasks_attributes, :required, 'Array of task attributes for nested update'
    end

    swagger_model :tasks_attributes do
      property :tasks_attributes, :array, :required, 'Array of task attributes', { 'items' => { '$ref' => 'task' } }
    end

    swagger_model :task do
      description 'nested task attributes for a specific project'
      property :id, :string, :required, 'Task Id'
      property :name, :string, :optional, 'Task name'
      property :description, :string, :optional, 'Task description'
      property :state, :string, :optional, 'Task state'
    end

    def bulk_update
      project = Project.find_by id: params[:project_id]
      if project.present? && project.update_attributes(bulk_task_params)
        render json: project.tasks
      elsif project.present?
        render json: { errors: project.errors.full_messages }, status: 400
      else
        render json: { errors: ['Project(s) not found'] }, status: 404
      end
    end

    private

    def index_params
      params.permit(:page, :page_size, :project_id).to_h.symbolize_keys
    end

    def task_params
      params.permit(:name, :description, :state)
    end

    def bulk_task_params
      params.require(:project).permit(tasks_attributes: [:id, :name, :description, :state])
    end
  end
end
