class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  # フォローする側
  has_many :relationships, foreign_key: :following_id
  # relationshipsテーブルのfollowing_idを参照しにいく
  has_many :followings, through: :relationships, source: :follower
  # あるユーザーがフォローしている人(follower フォローされる人)全員を取ってくる

  # フォローされる
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: :follower_id
  # relationshipsテーブルのfollower_idを参照しにいく(reverse_of~は存在しないテーブルなので、後にclass_nameで指定してあげる)
  has_many :followers, through: :reverse_of_relationships, source: :following
  # あるユーザーをフォローしてくれている人(following フォローする人)全てを取ってくる

  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: {maximum: 50}

  def self.looks(searches,words)
    # searchアクションで使用するsearches,wordsを引数を受け取るlooksメソッド
    if searches == "perfect_match"
      @user = User.where("name LIKE ?", "#{words}")
    elsif searches == "forword_match"
      @user = User.where("name LIKE ?", "#{words}%")
    elsif searches == "backword_match"
      @user = User.where("name LIKE ?", "%#{words}")
    elsif searches == "partial_match"
      @user = User.where("name LIKE ?", "%#{words}%")
    else
      @user = User.all
    end
      # ＠userに該当するもの全てを受け取るようにwhereメソッドを使う
      # User.where("name LIKE?","#{word}%")これはユーザーモデルに検索ワードがヒットしているか確認できる
      # "#{words}"部分を書き換えることで前方一致や完全一致などの検索ができる
  end

  def is_followed_by?(user)
    reverse_of_relationships.find_by(following_id: user.id).present?
    # あるユーザーが引数(user)に渡されたユーザーにフォローされているのか？されていればtrueを返す
  end

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
