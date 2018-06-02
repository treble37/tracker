require 'rails_helper'
require 'controllers/v1/shared/task_examples'

RSpec.describe V1::TasksController, type: :api do
  before do
    @project = FactoryGirl.create(:project_with_tasks,
                                  name: "Project #{Time.now.to_i}",
                                  description: "Project Desc #{Time.now.to_i}")
  end

  let(:response) { ActiveSupport::JSON.decode(last_response.body) }
  let(:serialized) { serialize_task_resource(task_resource) }

  context '#index' do
    before do
      get "/v1/projects/#{@project.id}/tasks"
    end

    it_behaves_like 'correct status code', 200

    let(:task_resource) { @project.tasks }

    it 'should return a response' do
      expect(response['tasks'].to_json).to match_unordered_json(serialized)
    end
  end

  context '#show' do
    before do
      @task = @project.tasks.first
      get "/v1/projects/#{@project.id}/tasks/#{@task.id}"
    end

    it_behaves_like 'correct status code', 200

    let(:task_resource) { @task }

    it_behaves_like 'api resource response'
  end

  context '#create' do
    before do
      @name_desc = "Task#{Time.now.to_i}"
      post "/v1/projects/#{@project.id}/tasks/",
           name: @name_desc, description: @name_desc, state: 'in_progress'
    end

    it_behaves_like 'correct status code', 201

    let(:task_resource) { Task.find_by name: @name_desc }

    it_behaves_like 'api resource response'
  end

  context '#update' do
    before do
      @task = @project.tasks.first
      put "/v1/projects/#{@project.id}/tasks/#{@task.id}",
          name: "RandomName#{Time.now.to_i}"
    end

    it_behaves_like 'correct status code', 200

    let(:task_resource) { @project.tasks.find_by(id: @task.id) }

    it_behaves_like 'api resource response'
  end

  context '#bulk_update' do
    before do
      task1 = @project.tasks.first
      put "/v1/projects/#{@project.id}/tasks/bulk_update",
          project: { tasks_attributes:
                    [{ id: task1.id,
                       name: "RandomNameHelloTask#{Time.now.to_i}",
                       description: 'RandomDescHelloTask',
                       state: 'in_progress' }] }
    end

    it_behaves_like 'correct status code', 200

    let(:task_resource) { @project.tasks }

    it_behaves_like 'api resource response'
  end
end
