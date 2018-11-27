require 'test_helper'

class SearchDonationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get search_donation_index_url
    assert_response :success
  end

end
