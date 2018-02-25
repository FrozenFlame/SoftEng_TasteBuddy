class Product
  include Mongoid::Document
  include Mongoid::Timestamps
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

  def self.search(search)
    if search
      any_of({prodCategory: /#{search}/i},{prodName: /#{search}/i},{prodDesc: /#{search}/i})
    end
  end
  
end
