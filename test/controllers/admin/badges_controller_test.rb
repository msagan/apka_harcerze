require 'test_helper'

class Admin::BadgesControllerTest < ActionController::TestCase
  setup do
    @badge = badges(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:badges)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create badge" do
    assert_difference('Badge.count') do
      post :create, badge: { color: @badge.color, comment: @badge.comment, description: @badge.description, name: @badge.name, user_id: @badge.user_id }
    end

    assert_redirected_to admin_badge_path(assigns(:badge))
  end

  test "should show badge" do
    get :show, id: @badge
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @badge
    assert_response :success
  end

  test "should update badge" do
    patch :update, id: @badge, badge: { color: @badge.color, comment: @badge.comment, description: @badge.description, name: @badge.name, user_id: @badge.user_id }
    assert_redirected_to admin_badge_path(assigns(:badge))
  end

  test "should destroy badge" do
    assert_difference('Badge.count', -1) do
      delete :destroy, id: @badge
    end

    assert_redirected_to admin_badges_path
  end
end
