require "cgi"

module Drip
  class Client
    module Purchases
      # Public: Create a purchase.
      #
      # email   - Required. The String email address of the subscriber.
      # amount  - Required. The total amount of the purchase in cents.
      # options - A Hash of options.
      #           - properties    - Optional. An Object containing properties about
      #                             the order.
      #           - items         - Optional. An Array of objects containing information
      #                             about specific order items.
      #                             - name        - Required. The product name.
      #                             - amount      - Required. The line total (in
      #                                             cents).
      #                             - quantity    - Optional. The quantity of the
      #                                             item purchased (if omitted,
      #                                             defaults to 1).
      #                             - product_id  - Optional. A unique identifier
      #                                             for the specific product.
      #                             - sku         - Optional. The product SKU number.
      #                             - properties  - Optional. An Object containing
      #                                             properties about the line item.
      #            - provider    - Optional. The identifier for the provider from
      #                            which the purchase data was received
      #            - order_id    - Optional. A unique identifier for the order
      #                            (generally the primary key generated by the
      #                            order management system).
      #            - permalink   - Optional. A URL for the human-readable
      #                            interface to view the order details.
      #            - occurred_at - Optional. The String time at which the event
      #                            occurred in ISO-8601 format. Defaults to the
      #                            current time.
      #
      # Returns a Drip::Response.
      # See https://www.getdrip.com/docs/rest-api#create_purchase
      def create_purchase(email, amount, options = {})
        data = options.merge(amount: amount)
        post "#{account_id}/subscribers/#{CGI.escape email}/purchases", generate_resource("purchases", data)
      end

      # Public: Fetch a list of purchases for a subscriber.
      #
      # email - The String email address of the subscriber.
      #
      # Returns a Drip::Response.
      # See https://www.getdrip.com/docs/rest-api#list_purchases
      def purchases(email)
        get "#{account_id}/subscribers/#{CGI.escape email}/purchases"
      end

      # Public: Fetch a purchase.
      #
      # email - The String email address of the subscriber.
      # id    - The String ID of the purchase
      #
      # Returns a Drip::Response.
      # See https://www.getdrip.com/docs/rest-api#list_purchases
      def purchase(email, id)
        get "#{account_id}/subscribers/#{CGI.escape email}/purchases/#{id}"
      end
    end
  end
end
