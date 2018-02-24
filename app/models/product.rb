class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  field :prodCode, type: String
  field :prodCategory, type: String
  field :prodName, type: String
  field :prodDesc, type: String
  field :price, type: BigDecimal
  field :deleted, type: Boolean, default: false

  def isDeleted?
    deleted == true
  end

end
