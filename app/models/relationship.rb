class Relationship < ApplicationRecord
  # フォローする側
  belongs_to :following, class_name: "User"
  # followingというテーブルはないのでUserテーブルにあるものだと認識させるためにclass_name: "User"をつける
  
  # フォローされる側
  belongs_to :follower, class_name: "User"
  # followerというテーブルはないのでUserテーブルにあるものだと認識させるためにclass_name: "User"をつける
end
