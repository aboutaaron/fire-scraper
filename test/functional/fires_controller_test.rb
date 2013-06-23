require 'test_helper'

class FiresControllerTest < ActionController::TestCase
  setup do
    @fire = fires(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fires)
  end

  test "should create fire" do
    assert_difference('Fire.count') do
      post :create, fire: { acreage: @fire.acreage, containment: @fire.containment, county_id: @fire.county_id, date: @fire.date, location: @fire.location, name: @fire.name }
    end

    assert_response 201
  end

  test "should show fire" do
    get :show, id: @fire
    assert_response :success
  end

  test "should update fire" do
    put :update, id: @fire, fire: { acreage: @fire.acreage, containment: @fire.containment, county_id: @fire.county_id, date: @fire.date, location: @fire.location, name: @fire.name }
    assert_response 204
  end

  test "should destroy fire" do
    assert_difference('Fire.count', -1) do
      delete :destroy, id: @fire
    end

    assert_response 204
  end
end
