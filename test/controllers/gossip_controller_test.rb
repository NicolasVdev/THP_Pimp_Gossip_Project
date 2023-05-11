require "test_helper"

class GossipControllerTest < ActionDispatch::IntegrationTest
  test "should get gossip" do
    get gossip_gossip_url
    assert_response :success
  end
end
