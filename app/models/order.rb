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
    # special measures have to be taken
    cookie = "cookie"
    if search
      any_of({orderDate: /#{search}/i},{orderUser: /#{search}/i})
    end
  end
  def check_match(search)
    Ordrcontentgetter.get_names(search)
    return 
  end

  def minusOne(inp)
    return inp-1
  end

end
