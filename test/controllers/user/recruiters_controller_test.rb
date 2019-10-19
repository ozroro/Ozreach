require 'test_helper'

class User::RecruitersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_recruiters_index_url
    assert_response :success
  end

  test "should get show" do
    get user_recruiters_show_url
    assert_response :success
  end

  test "should get new" do
    get user_recruiters_new_url
    assert_response :success
  end

  test "should get edit" do
    get user_recruiters_edit_url
    assert_response :success
  end

end
