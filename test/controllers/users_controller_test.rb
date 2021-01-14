require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup 
    @user = users(:hfpang)
    @other_user = users(:michael)
  end

  test "should get new" do
    get new_user_path
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get '/users/:id/edit', params: { id: @user.id}
    assert_not flash.empty?
    assert_redirected_to login_path
  end

  test "should redirect update when not logged in" do
    patch '/users/:id', params: {id: @user.id, user: {
      name: @user.name,
      email: @user.email
    }}
    assert_not flash.empty?
    assert_redirected_to login_path
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_path(@user.id)
    assert flash.empty?
    assert_redirected_to root_path 
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch user_path(@user.id), params: { user: {
      name: @user.name,
      email: @user.email
    }}
    assert flash.empty?
    assert_redirected_to root_path
  end
end
