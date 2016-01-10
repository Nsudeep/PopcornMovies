require 'test_helper'

class ViewsControllerTest < ActionController::TestCase
  test "should get rate" do
    get :rate
    assert_response :success
  end

  test "should get review" do
    get :review
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get average" do
    get :average
    assert_response :success
  end

end
