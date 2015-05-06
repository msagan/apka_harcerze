require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { address_1: @user.address_1, address_2: @user.address_2, description: @user.description, first_name: @user.first_name, last_name: @user.last_name, medical_info: @user.medical_info, parental_agreement: @user.parental_agreement, pesel: @user.pesel, school: @user.school, school_class: @user.school_class, stars: @user.stars, team_id: @user.team_id }
    end

    assert_redirected_to admin_user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { address_1: @user.address_1, address_2: @user.address_2, description: @user.description, first_name: @user.first_name, last_name: @user.last_name, medical_info: @user.medical_info, parental_agreement: @user.parental_agreement, pesel: @user.pesel, school: @user.school, school_class: @user.school_class, stars: @user.stars, team_id: @user.team_id }
    assert_redirected_to admin_user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to admin_users_path
  end
end
