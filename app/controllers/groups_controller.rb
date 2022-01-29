class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def new
    @group = Group.new
  end

  def index
    @groups = Group.all
    @book = Book.new
  end

  def join
    @group = Group.find(params[:group_id])
    @group.users << current_user
    # @group.usersにcurrent_userを追加する
    redirect_to groups_path
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    @group.users << current_user
    # joinで記述した内容と同じ。これを記述しないとグループ作成者がメンバーとしてカウントされない
    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
    @book = Book.new
  end


  def edit
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_path
    else
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.users.destroy(current_user)
    # current_userは@group.usersから削除される
    redirect_to groups_path
  end


  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end

end
