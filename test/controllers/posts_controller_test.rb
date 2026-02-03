require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  include ActionDispatch::TestProcess::FixtureFile

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

  test "should create post with image" do
    assert_difference("Post.count", 1) do
      post posts_path, params: {
        post: {
          title: "Test Title",
          body: "Test Body",
          image: fixture_file_upload(
            "test/fixtures/files/test.jpeg",
            "image/jpeg"
          )
        }
      }
    end

    created_post = Post.last
    assert created_post.image.attached?
    assert created_post.uuid.present?
    assert_redirected_to posts_path
  end
end
