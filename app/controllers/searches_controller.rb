class SearchesController < ApplicationController
    def search
        @range = params[:range]
        # search = params[:search]
        # word = params[:word]
        # @users = User.looks(search, word)

        if @range == "User"
        # @rangeにはプルダウンでUserかBookが入っている
        # UserがtrueだったらUser.looksメソッドから取り出したデータを@usersに代入する
        # falseだったらBook.looksメソッドから取り出したデータを@booksに代入する
            @users = User.looks(params[:search], params[:word])
        else
            @books = Book.looks(params[:search], params[:word])
        end
    end
end
