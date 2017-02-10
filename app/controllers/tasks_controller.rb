class TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy]

  # GET /tasks
  api :GET, '/task/', 'Task List'
  description 'Ability for show all task list'
  def index
    @tasks = Task.all.order(id: :desc)

    render json: { tasks: @tasks }
  end

  # GET /tasks/1
  # def show
  #   render json: @task
  # end

  # POST /tasks
  api :POST, '/task/', 'Create Process'
  param :task, ActionController::Parameters, desc: 'Task' do
    param :text, String, desc: 'Task text', required: true
  end

  description 'Ability for create new task list'
  def create
    @task = Task.new(task_params)

    if @task.save
      render json: @task, status: :created, location: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  api :PUT, '/task/:id', 'Update Process'
  param :task, ActionController::Parameters, desc: 'Task' do
    param :text, String, desc: 'Task text', required: true
  end

  description 'Ability for update new task list'
  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1
  api :DELETE, '/task/:id', 'Delete Process'
  def destroy
    @task.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:id, :text, :aasm_state)
    end
end
