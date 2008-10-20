class CashBooksController < ApplicationController
  before_filter :login_required
  before_filter :user_allowed, :except => [:index, :new, :create]
  
  def index
    @cash_books = CashBook.find_all_by_owner_id(current_user)
    @cash_books += current_user.cash_books
  end
  
  def show
    @cash_book = CashBook.find(params[:id])
    session[:cash_book_id] = params[:id]
    @last_entries = Entry.find_all_by_cash_book_id(@cash_book, :limit  => 5, :order => 'id desc')
    @entry = Entry.new
  end
  
  def new
    @cash_book = CashBook.new
  end
  
  def create
    params[:cash_book][:owner] = current_user
    @cash_book = CashBook.new(params[:cash_book])
    if @cash_book.save
      flash[:notice] = "Successfully created cashbook."
      redirect_to @cash_book
    else
      render :action => 'new'
    end
  end
  
  def edit
    @cash_book = CashBook.find(params[:id])
  end
  
  def update
    @cash_book = CashBook.find(params[:id])
    params[:cash_book][:owner] = current_user
    params[:cash_book][:user_ids] ||= []
    if @cash_book.update_attributes(params[:cash_book])
      flash[:notice] = "Successfully updated cashbook."
      redirect_to @cash_book
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @cash_book = CashBook.find(params[:id])
    @cash_book.destroy
    flash[:notice] = "Successfully destroyed cashbook."
    redirect_to cash_books_url
  end
  
  private
  
  def user_allowed
    @cash_book = CashBook.find(params[:id])
    if @cash_book.users.include?(current_user) || @cash_book.owner == current_user
      return true
    else
      redirect_to cash_books_url
    end
  end
end
