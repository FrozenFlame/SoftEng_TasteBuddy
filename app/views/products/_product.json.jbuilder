json.extract! product, :id, :prodCode, :prodCategory, :prodName, :prodDesc, :price, :created_at, :updated_at
json.url product_url(product, format: :json)
