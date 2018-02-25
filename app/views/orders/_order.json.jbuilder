json.extract! order, :id, :orderCode, :orderDate, :orderUser, :orderContents, :created_at, :updated_at
json.url order_url(order, format: :json)
