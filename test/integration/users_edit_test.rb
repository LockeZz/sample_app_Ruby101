require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup 
    @user = users(:hfpang)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: {
      name: "",
      email: "foo@invalid",
      password: "foo",
      password_confirmation: "bar"
    }}
    assert_template 'users/edit'
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: {
      name: "hfpang",
      email: "hfpang@example.com",
      password: "",
      password_confirmation: ""
    }}
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal "hfpang", @user.name
    assert_equal "hfpang@example.com", @user.email 
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    patch user_path(@user), params: { user: {
      name: "hfpang",
      email: "hfpang@example.com",
      password: "",
      password_confirmation: ""
    }}
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal "hfpang", @user.name
    assert_equal "hfpang@example.com", @user.email 
  end
end
