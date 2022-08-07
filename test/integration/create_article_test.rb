require "test_helper"

class CreateArticleTest < ActionDispatch::IntegrationTest

    setup do
        @user = User.create(username: "johndoe", email: "johndoe@example.com", password: "password")
        sign_in_as(@user)
        @category1 = Category.create(name: "Sports")
        @category2 = Category.create(name: "Tech")
    end

    test "get article form and create article" do
        get "/articles/new"
        assert_response :success
        assert_difference 'Article.count', 1 do
            post articles_path, params: { article: { title: "Test Title", description: "Test Description", category_ids: [@category1.id, @category2.id] } }
            assert_response :redirect
        end
        follow_redirect!
        assert_response :success
        assert_equal "Article was created successfully.", flash[:notice]
    end
end