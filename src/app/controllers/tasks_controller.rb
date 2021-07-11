class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :find_task, only: [:edit, :update, :destroy, :done]
  before_action :force_redirect_unless_my_task, only: [:edit, :update, :destroy, :done]

  def index
    @tasks = Task.all

    if params[:id].present?
      @task = Task.find(params[:id])
    else
      @task = nil
    end
  end

  def show
    redirect_to tasks_path
  end

  def new
    return redirect_to new_profile_path, alert: "ニックネームを登録してください" if current_user.profile.blank?
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
    @task.user = current_user
    @task.status = 0

    if @task.save
      flash[:success] = 'タスクが投稿されました'
      redirect_to "/"
    else
      flash[:danger] = 'タスクが投稿されません'
      render :new
    end
  end

  def edit

  end

  def update


    if @task.update(task_params)
      flash[:success] = 'タスクが編集されました'
      redirect_to "/"
    else
      flash.now[:danger] = 'タスクが編集されませんでした'
      render :new
    end
  end

/カレンダー機能/
  def calender
    @tasks = Task.all
  end

  def destroy

    @task.destroy

    flash[:success] = 'タスクが削除されました'
    redirect_to tasks_path
  end

  def done
    if @task.status == 1
      @task.status = 0
    else
      @task.status = 1
    end
    @task.save
    redirect_to tasks_path
  end
end

private

def task_params
  params.require(:task).permit(:name, :description, :start_time)
end

def find_task
  @task = Task.find(params[:id])
end

def force_redirect_unless_my_task
  return redirect_to root_path, alert: "自分のタスクではありません。" if @task.user != current_user
end
