require 'test_helper'

class CountiesControllerTest < ActionController::TestCase
  setup do
    @county = counties(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:counties)
  end

  test "should create county" do
    assert_difference('County.count') do
      post :create, county: { name: @county.name }
    end

    assert_response 201
  end

  test "should show county" do
    get :show, id: @county
    assert_response :success
  end

  test "should update county" do
    put :update, id: @county, county: { name: @county.name }
    assert_response 204
  end

  test "should destroy county" do
    assert_difference('County.count', -1) do
      delete :destroy, id: @county
    end

    assert_response 204
  end
end
