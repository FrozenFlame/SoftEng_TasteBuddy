class Order
  include Mongoid::Document
  include Mongoid::Timestamps
  field :orderCode, type: String    # code of order
  field :orderDate, type: DateTime      # date when order was made
  field :orderDateStr, type: String, default: -> { orderDate.to_s }
  field :orderUser, type: String    # user who made order
  field :orderNames, type: String
  field :orderContents, type: Array, default: []     # order's contents (prodCode and quantity)
  field :deleted, type: Boolean, default: false
  # field :_id, type: String, default: -> { orderCode.to_s.parameterize } # this makes it so the link above would be reflected here 

  def isDeleted?
    deleted == true
  end

  def product_list=(arg)
    self.orderContents = arg.split(',').map { |v| v.strip }
  end 

  def product_list
    self.orderContents.join(', ')
  end

  def self.search(search) #basically for admin
    if search
      any_of({orderUser: /#{search}/i},{orderNames: /#{search}/i})
    end
  end

  def self.searchFiltered(search, userid)
    
    if search
      where(orderNames:/#{search}/i , orderUser: userid)
    end
  end

  

  def minusOne(inp) #nothing but a test method
    return inp-1
  end

end
