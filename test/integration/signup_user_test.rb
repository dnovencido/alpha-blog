require "test_helper"

class SignupUserTest < ActionDispatch::IntegrationTest
    
    test "get signup form and signup a user" do
        get "/signup"
        assert_response :success
        assert_difference 'User.count', 1 do
            post users_path, params: { user: { username: "johndoe", email: "johndoe@gmail.com", password: "johndoe123" } }
            assert_response :redirect
        end
        follow_redirect!
        assert_response :success
        assert_match "successfully sign up", response.body
        assert_select 'div.alert-success'
    end
    
end