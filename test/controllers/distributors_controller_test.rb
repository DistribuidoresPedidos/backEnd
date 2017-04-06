require 'test_helper'

class DistributorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @distributor = distributors(:one)
  end

  test "should get index" do
    get distributors_url, as: :json
    assert_response :success
  end

  test "should create distributor" do
    assert_difference('Distributor.count') do
      post distributors_url, params: { distributor: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show distributor" do
    get distributor_url(@distributor), as: :json
    assert_response :success
  end

  test "should update distributor" do
    patch distributor_url(@distributor), params: { distributor: {  } }, as: :json
    assert_response 200
  end

  test "should destroy distributor" do
    assert_difference('Distributor.count', -1) do
      delete distributor_url(@distributor), as: :json
    end

    assert_response 204
  end
end
