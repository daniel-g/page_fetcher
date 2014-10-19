class Page
  include Mongoid::Document

  field :uid, type: String
  field :username, type: String
end
