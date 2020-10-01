class TasksController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = Task.all
  end
  
  def show
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    
    if @task.save
      #flashはハッシュ{ success: '文字列'} :successは緑色の背景
      flash[:success] = "タスクが正常に投稿されました"
      #redirect_to リンク先を指定して強制的に飛ばす
      redirect_to @task
    else
      #dengerは赤色の背景
      flash.now[:denger] = 'タスクが投稿されませんでした'
      #renderは:newを表示
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @task.update(task_params)
      flash[:success] = 'タスクは正常に更新されました'
      redirect_to @task
    else
      flash.now[:denger] = 'タスクは更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    
    flash[:success] = 'タスクは正常に削除されました'
    redirect_to tasks_url
  end
  
  #privateでアクションではなく、このクラス内での使用を明示
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  #Strong Parameter セキュリティ対策 送信されてきたデータのフィルタリング
  def task_params
    #params.require(:task)でTaskモデルのフォームからのデータと明示
    #.permit(:content)で必要なカラムだけを選択
    params.require(:task).permit(:content, :status)
  end
end
