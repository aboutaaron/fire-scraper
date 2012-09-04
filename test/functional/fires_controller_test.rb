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

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fire" do
    assert_difference('Fire.count') do
      post :create, fire: { date_fires_started: @fire.date_fires_started, fire_address: @fire.fire_address, fire_contained: @fire.fire_contained, fire_county: @fire.fire_county, fire_name: @fire.fire_name, last_date_fire_updated: @fire.last_date_fire_updated, total_acres_burned: @fire.total_acres_burned }
    end

    assert_redirected_to fire_path(assigns(:fire))
  end

  test "should show fire" do
    get :show, id: @fire
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fire
    assert_response :success
  end

  test "should update fire" do
    put :update, id: @fire, fire: { date_fires_started: @fire.date_fires_started, fire_address: @fire.fire_address, fire_contained: @fire.fire_contained, fire_county: @fire.fire_county, fire_name: @fire.fire_name, last_date_fire_updated: @fire.last_date_fire_updated, total_acres_burned: @fire.total_acres_burned }
    assert_redirected_to fire_path(assigns(:fire))
  end

  test "should destroy fire" do
    assert_difference('Fire.count', -1) do
      delete :destroy, id: @fire
    end

    assert_redirected_to fires_path
  end
end
