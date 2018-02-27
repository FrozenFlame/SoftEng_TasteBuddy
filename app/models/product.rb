class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  # wow... what a waste of time 
  # apparently ther'es a module called Mongoid::Paranoia, which allows you to only soft delete your items
  field :prodCode, type: String
  field :prodCategory, type: String
  field :prodName, type: String
  field :prodDesc, type: String
  field :price, type: BigDecimal
  field :deleted, type: Boolean, default: false
  field :pathToImg, type: String, default: 'assets/no-img.png'
  # field :_id, type: String, default: -> { prodCode.to_s.parameterize } # this makes it so the link above would be reflected here BUT only if they have been newly created, this breaks old links

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

  def get_string
    return "hel"
  end
  
end

# make use of 'attr accessible
# e.g.:
# attr accessible :name, :price, :released_on
