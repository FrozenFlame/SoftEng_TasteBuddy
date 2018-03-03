class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :userid, type: String               # identifier
  field :username, type: String             # username used to log in
  field :password, type: String             # password to validate log in
  field :orders, type: Array   # filled with order codes
  field :cart, type: Array     # filled with what they have in their shopping cart, still coordinated in the database.
  field :isAdmin, type: Boolean, default: false
  # field :_id, type: String, default: -> { prodCode.to_s.parameterize } # this makes it so the link above would be reflected here BUT only if they have been newly created
  
end