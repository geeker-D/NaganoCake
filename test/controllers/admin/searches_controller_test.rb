require "test_helper"

class Admin::SearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get search_item" do
    get admin_searches_search_item_url
    assert_response :success
  end
end
