class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users, dependent: :destroy
  # usersはthrough記述で中間テーブルを通じてgroupsにアクセスできるようにする

  validates :name, presence: true
  validates :introduction, presence: true

  has_one_attached :image

  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end
end
