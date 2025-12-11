require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user

    @post = posts(:one)
  end

  test "should get index" do
    get posts_path
    assert_response :success
  end

  test "should get show" do
    get post_path(@post)
    assert_response :success
  end

  test "should get new" do
    get new_post_path
    assert_response :success
  end

  test "should create post" do
    assert_difference("Post.count", 1) do
      post posts_path, params: {
        post: {
          title: "Test Title",
          body: "Test Body"
        }
      }
    end

    assert_redirected_to post_path(Post.last)
  end
end
