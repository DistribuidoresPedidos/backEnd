require 'test_helper'

class OfferedProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @offered_product = offered_products(:one)
  end

  test "should get index" do
    get offered_products_url, as: :json
    assert_response :success
  end

  test "should create offered_product" do
    assert_difference('OfferedProduct.count') do
      post offered_products_url, params: { offered_product: { distributor_id: @offered_product.distributor_id, price: @offered_product.price, product_id: @offered_product.product_id } }, as: :json
    end

    assert_response 201
  end

  test "should show offered_product" do
    get offered_product_url(@offered_product), as: :json
    assert_response :success
  end

  test "should update offered_product" do
    patch offered_product_url(@offered_product), params: { offered_product: { distributor_id: @offered_product.distributor_id, price: @offered_product.price, product_id: @offered_product.product_id } }, as: :json
    assert_response 200
  end

  test "should destroy offered_product" do
    assert_difference('OfferedProduct.count', -1) do
      delete offered_product_url(@offered_product), as: :json
    end

    assert_response 204
  end
end
