class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @user = @book.user
    # create.jsに変数@userがあるから渡せるようにしておかないといけない
    @comment = @book.book_comments.new(book_comment_params)
    # book変数に代入したbook.idを空のbook_commentsに代入して新規投稿できるようにする
    # comment = BookComment.new(book_comment_params)
    @comment.user_id = current_user.id
    # comment.book_id = book.id
    @comment.save
  end

  def destroy
    BookComment.find(params[:id]).destroy
    @book = Book.find(params[:book_id])
    @user = @book.user
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
