class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  def index
    if params[:sort_expired]
      @tasks = current_user.tasks.select(:id, :task_name, :discription, :expired_at, :status, :priority, :created_at,).order("expired_at DESC")
    elsif params[:sort_priority]
      @tasks = current_user.tasks.select(:id, :task_name, :discription, :expired_at, :status, :priority, :created_at,).order("priority ASC")
    else
      if params[:task].present?
        if params[:task][:task_name].present? && params[:task][:status].present?
          @tasks = current_user.tasks.search_task_name(params[:task][:task_name]).search_status(params[:task][:status]).order("created_at DESC")
        elsif params[:task][:task_name].present?
          @tasks = current_user.tasks.search_task_name(params[:task][:task_name]).order("created_at DESC")
        elsif params[:task][:status].present?
          @tasks = current_user.tasks.search_status(params[:task][:status]).order("created_at DESC")
        elsif params[:task][:label_id].present?
          @tasks = current_user.tasks.search_label(params[:task][:label_id]).order("created_at DESC")
        end
      else
        @tasks = current_user.tasks.select(:id, :task_name, :discription, :expired_at, :status, :priority, :created_at,).order("created_at DESC")
      end
    end
    @tasks = @tasks.page(params[:page]).per(8)
  end
  def show
  end
  def new
    @task = current_user.tasks.new
  end
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to task_path(@task.id)
      flash[:success] = "新たなタスク「#{@task.task_name}」が作成されました"
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
    params.require(:task).permit(:task_name, :discription, :expired_at, :status, :priority, { label_ids: [] })
  end
  def set_task
    @task = Task.find(params[:id])
  end
end
