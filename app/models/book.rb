class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}


  def self.looks(searches,words)
    # searchアクションで使用するsearches,wordsを引数を受け取るlooksメソッド
    if searches == "perfect_match"
      @book = Book.where("title LIKE ?", "#{words}")
    elsif searches == "forword_match"
      @book = Book.where("title LIKE ?", "#{words}%")
    elsif searches == "backword_match"
      @book = Book.where("title LIKE ?", "%#{words}")
    elsif searches == "partial_match"
      @book = Book.where("title LIKE ?", "%#{words}%")
    else
      @book = Book.all
    end
      # ＠bookに該当するもの全てを受け取るようにwhereメソッドを使う
      # Book.where("title LIKE?","#{word}%")これはブックモデルに検索ワードがヒットしているか確認できる
      # "#{words}"部分を書き換えることで前方一致や完全一致などの検索ができる
  end


  def favorited_by?(user)
    favorites.exists?(user_id:user.id)
  end

end
