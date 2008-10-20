class EntriesController < ApplicationController
  before_filter :login_required
  
  def report
    @date_from = Date.new(params[:entries]["filter(1i)"].to_i,params[:entries]["filter(2i)"].to_i)
    @date_to = (@date_from+1.month)-1.day
    @current_cash_book = CashBook.find(session[:cash_book_id])
    @entries = Entry.find_all_by_cash_book_id(session[:cash_book_id], :conditions => {:date => @date_from..@date_to})
    @revenue_sum = 0
    @expenditure_sum = 0
    @entries.each do |e|
      @revenue_sum += e.revenue
      @expenditure_sum += e.expenditure
    end
  end
  
  def index
    @entries = Entry.find_all_by_cash_book_id(session[:cash_book_id])
    @current_cash_book = CashBook.find(session[:cash_book_id])
    @revenue_sum = 0
    @expenditure_sum = 0
    @entries.each do |e|
      @revenue_sum += e.revenue
      @expenditure_sum += e.expenditure
    end
  end
  
  def show
    @entry = Entry.find(params[:id])
  end
  
  def new
    @entry = Entry.new
  end
  
  def create
    params[:entry][:cash_book_id] = session[:cash_book_id]
    params[:entry][:user_id] = current_user.id
    params[:entry][:revenue].gsub!(/,/,'.')
    params[:entry][:expenditure].gsub!(/,/,'.')
    @entry = Entry.new(params[:entry])
    if @entry.save
      flash[:notice] = "Posten erfolgreich hinzugefügt."
      respond_to do |format|
        format.html { redirect_to @entry }
        format.js
      end
    else
      render :action => 'new'
    end
  end
  
  def edit
    @entry = Entry.find(params[:id])
  end
  
  def update
    @entry = Entry.find(params[:id])
    params[:entry][:revenue].gsub!(/,/,'.')
    params[:entry][:expenditure].gsub!(/,/,'.')
    if @entry.update_attributes(params[:entry])
      flash[:notice] = "Successfully updated entry."
      redirect_to @entry
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy
    flash[:notice] = "Successfully destroyed entry."
    redirect_to entries_url
  end
end
