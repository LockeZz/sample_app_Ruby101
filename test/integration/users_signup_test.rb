require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: {user: {
        name: " ", 
        email: "user@invalid", 
        password: "asdasd", 
        password_confirmation: "asdasd"
      }}
    end
    assert_template 'users/new'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do 
      post users_path, params: {user: {
        name: "example user",
        email: "user@user.com",
        password: "asdasd",
        password_confirmation: "asdasd"
      }}
      follow_redirect!
    end
    assert_template 'users/show'
    assert is_logged_in?
  end
end
