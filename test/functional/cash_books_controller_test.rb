require 'test_helper'

class CashBooksControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => CashBook.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    CashBook.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    CashBook.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to cash_book_url(assigns(:cash_book))
  end
  
  def test_edit
    get :edit, :id => CashBook.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    CashBook.any_instance.stubs(:valid?).returns(false)
    put :update, :id => CashBook.first
    assert_template 'edit'
  end
  
  def test_update_valid
    CashBook.any_instance.stubs(:valid?).returns(true)
    put :update, :id => CashBook.first
    assert_redirected_to cash_book_url(assigns(:cash_book))
  end
  
  def test_destroy
    cash_book = CashBook.first
    delete :destroy, :id => cash_book
    assert_redirected_to cash_books_url
    assert !CashBook.exists?(cash_book.id)
  end
end
