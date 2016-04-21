json.array!(@products) do |product|
  json.extract! product, :id, :name, :unit_price, :total_stock_count, :sold_out, :sold_out_at
  json.url product_url(product, format: :json)
end
