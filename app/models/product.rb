class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  include Searchable
  field :prodCode, type: String
  field :prodCategory, type: String
  field :prodName, type: String
  field :prodDesc, type: String
  field :price, type: BigDecimal
  field :deleted, type: Boolean, default: false
  field :pathToImg, type: String, default: 'assets/no-img.png'

  def isDeleted?
    deleted == true
  end

  validates :prodCategory, presence: true
  validates :prodName, presence: true, length:{minimum: 5}
  validates :price, presence:true, :if => :isCurrency?

  def isCurrency?
    self.is_a?(BigDecimal)
  end
  
end
