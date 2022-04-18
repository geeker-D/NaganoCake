require "test_helper"

class Public::SearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get search_item" do
    get public_searches_search_item_url
    assert_response :success
  end

  test "should get search_genre" do
    get public_searches_search_genre_url
    assert_response :success
  end
end
