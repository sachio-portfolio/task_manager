class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update ]
  def index
    @tasks = Task.all
  end
  def show
  end
  def new
    if params[:back]
      @task = Task.new(task_params)
    else
      @task = Task.new
    end
  end
  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to task_path(@task.id)
      flash[:notice] = "新しいタスクが作成されました"
    else
      render :new
    end
  end
  def edit
  end
  def update
    if @task.update(task_params)
      redirect_to task_path(@task.id)
      flash[:notice] = "タスクの編集が完了しました"
    else
      render :edit
    end
  end
  private
  def task_params
    params.require(:task).permit(:task_name, :discription,)
  end
  def set_task
    @task = Task.find(params[:id])
  end
end
