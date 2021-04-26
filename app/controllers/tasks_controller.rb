class TasksController < ApplicationController
  before_action :set_task, only: %i[ show ]
  def index
    @tasks = Task.all()
  end
  def show
  end

  private
  def task_params
    params.require(:task).permit(:task_name, :discription,)
  end
  def set_task
    @task = Task.find(params[:id])
  end
end
