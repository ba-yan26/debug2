class FavoritesController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    # favorite = Favorite.new(book_id :book.id)
    # favorite.user_id = current_user.id
    favorite = current_user.favorites.new(book_id:book.id)
    favorite.save
    redirect_to books_path(book)
  end

  def destroy
    book = Book.find(params[:book_id])
    # favorite = Favorite.find_by(book_id :book.id)
    # favorite.user_id = current_user.id
    favorite = current_user.favorites.find_by(book_id:book.id)
    favorite.destroy
    redirect_to books_path(book)
  end

end
