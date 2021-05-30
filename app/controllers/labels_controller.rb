class LabelsController < ApplicationController
  def new
    @label = Label.new
  end
  def create
    @label = Label.new(label_params)
    if @label.save
      redirect_to tasks_path
      flash[:success] = "新たなラベル「#{@label.label_name}」を作成しました"
    else
      render :new
    end
  end
  def show
  end
  def edit
  end
  def update
  end
  def destroy
  end
  private
  def label_params
    params.require(:label).permit(:label_name,)
  end
  def set_label
    @label = Label.find(params[:id])
  end
end
