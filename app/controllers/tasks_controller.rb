class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  def index
    if params[:sort_expired]
      @tasks = Task.all.order("expired_at DESC")
    elsif params[:sort_priority]
      @tasks = Task.all.order("priority ASC")
    else
      if params[:task].present?
        if params[:task][:task_name].present? && params[:task][:status].present?
          @tasks = Task.search_task_name(params[:task][:task_name]).search_status(params[:task][:status])
        elsif params[:task][:task_name].present?
          @tasks = Task.search_task_name(params[:task][:task_name])
        elsif params[:task][:status].present?
          @tasks = Task.search_status(params[:task][:status])
        end
      else
        if params[:sort_expired].present?
          @tasks = Task.all.order("expired_at DESC")
        else
          @tasks = Task.all.order("created_at DESC")
        end
      end
    end
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
      flash[:notice] = "新たなタスク「#{@task.task_name}」が作成されました"
    else
      render :new
    end
  end
  def edit
  end
  def update
    if @task.update(task_params)
      redirect_to task_path(@task.id)
      flash[:notice] = "タスク「#{@task.task_name}」の編集が完了しました"
    else
      render :edit
    end
  end
  def destroy
    @task.destroy
    redirect_to tasks_path
    flash[:notice] = "タスクを削除しました"
  end
  private
  def task_params
    params.require(:task).permit(:task_name, :discription, :expired_at, :status, :priority,)
  end
  def set_task
    @task = Task.find(params[:id])
  end
end
