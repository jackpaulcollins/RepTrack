json.extract! product, :id, :account_id, :name, :description, :created_at, :updated_at
json.url product_url(product, format: :json)
json.description product.description.to_s
