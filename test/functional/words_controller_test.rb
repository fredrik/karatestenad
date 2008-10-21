require '../test_helper'

class WordsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:words)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_word
    assert_difference('Word.count') do
      post :create, :word => { :word => "yes" }
    end

    assert_redirected_to word_path(assigns(:word))
  end

  def test_should_show_word
    get :show, :id => words(:karatestenad).normalized
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => words(:karatestenad).normalized
    assert_response :success
  end

  def test_should_update_word
    put :update, :id => words(:karatestenad).normalized, :word => { }
    assert_redirected_to word_path(assigns(:word))
  end

  
  
end
