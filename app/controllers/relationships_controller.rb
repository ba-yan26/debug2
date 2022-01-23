class RelationshipsController < ApplicationController

  before_action :authenticate_user!

  def create
    following = current_user.relationships.build(follower_id: params[:user_id])
    # current_user.relationships.build・・・current_userに紐づいたrelationshipsを作る
    # follower_id :params[:user_id]・・・followerのidにparamsから取ってきたuseridを格納することができる
    following.save
    redirect_to request.referrer || root_path
    # 以前のパスに遷移する。見つからない場合はルートパスに遷移する。
  end

  def destroy
    following = current_user.relationships.find_by(follower_id: params[:user_id])
    following.destroy
    redirect_to request.referrer || root_path
  end

end
