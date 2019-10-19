require 'test_helper'

class User::SeekersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_seekers_index_url
    assert_response :success
  end

  test "should get show" do
    get user_seekers_show_url
    assert_response :success
  end

  test "should get new" do
    get user_seekers_new_url
    assert_response :success
  end

  test "should get edit" do
    get user_seekers_edit_url
    assert_response :success
  end

end
