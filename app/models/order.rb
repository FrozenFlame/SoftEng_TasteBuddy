class Order
  include Mongoid::Document
  include Mongoid::Timestamps
  field :orderCode, type: String    # code of order
  field :orderDate, type: Date      # date when order was made
  field :orderUser, type: String    # user who made order
  field :orderContents, type: Array, default: []     # order's contents (prodCode and quantity)
  field :deleted, type: Boolean, default: false
  def isDeleted?
    deleted == true
  end

  def product_list=(arg)
    self.orderContents = arg.split(',').map { |v| v.strip }
  end

  def product_list
    self.orderContents.join(', ')
  end

  def self.search(search)
    if search
      any_of({orderUser: /#{search}/i},{orderContents: /#{search}/i})
    end
  end
  
end
