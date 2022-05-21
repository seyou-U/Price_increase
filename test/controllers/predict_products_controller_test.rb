require "test_helper"

class PredictProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get predict_products_index_url
    assert_response :success
  end

  test "should get show" do
    get predict_products_show_url
    assert_response :success
  end

  test "should get new" do
    get predict_products_new_url
    assert_response :success
  end
end
