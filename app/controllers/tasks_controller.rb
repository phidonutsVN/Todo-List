class TasksController < ApplicationController
  before_action :require_login
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks.includes(:category, :tags).recent
  end

  def show
  end

  def new
    @task = current_user.tasks.build
    @categories = current_user.categories.order(:name)
  end

  def create
    @task = current_user.tasks.build(task_params)
    @categories = current_user.categories.order(:name)

    if @task.save
      # Handle tags if provided
      if params[:task][:tag_names].present?
        tag_names = params[:task][:tag_names].split(',').map(&:strip).reject(&:blank?)
        tag_names.each do |tag_name|
          @task.tags.create(name: tag_name)
        end
      end

      redirect_to @task, notice: 'Tác vụ đã được tạo thành công!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @categories = current_user.categories.order(:name)
  end

  def update
    if @task.update(task_params)
      # Handle tags update
      if params[:task][:tag_names].present?
        @task.tags.destroy_all
        tag_names = params[:task][:tag_names].split(',').map(&:strip).reject(&:blank?)
        tag_names.each do |tag_name|
          @task.tags.create(name: tag_name)
        end
      end

      redirect_to @task, notice: 'Tác vụ đã được cập nhật thành công!'
    else
      @categories = current_user.categories.order(:name)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'Tác vụ đã được xóa thành công!'
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :category_id, :status)
  end
end
