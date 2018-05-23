require File.dirname(__FILE__) + '/../../test_helper.rb'

class Drip::Client::PurchasesTest < Drip::TestCase
  def setup
    @client = Drip::Client.new { |c| c.account_id = "12345" }
  end

  context "#create_purchase" do
    setup do
      @email = "derrick@getdrip.com"
      @amount = 4900
      @options = {
        "email": @email,
        "provider": "shopify",
        "upstream_id": "abcdef",
        "amount": @amount,
        "tax": 100,
        "fees": 0,
        "discount": 0,
        "currency_code": "USD",
        "properties": {
          "size": "medium",
          "color": "red"
        }
      }
      @payload = { "orders" => [@options] }.to_json
      @response_status = 202
      @response_body = "stub"

      stub_request(:post, "https://api.getdrip.com/v2/12345/orders").
        to_return(status: @response_status, body: @response_body, headers: {})
    end

    should "send the right request" do
      expected = Drip::Response.new(@response_status, @response_body)
      assert_equal expected, @client.create_purchase(@email, @amount, @options)
    end
  end
end
