require 'test_helper'

class OrdersummaryControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ordersummary_index_url
    assert_response :success
  end

end
