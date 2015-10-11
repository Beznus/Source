json.array!(@quotes) do |quote|
  json.extract! quote, :id, :unit_price, :minimum_order_quantity, :product_id
  json.url quote_url(quote, format: :json)
end
