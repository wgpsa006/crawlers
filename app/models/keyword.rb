class Keyword < ActiveRecord::Base
  has_many :article_entries

  attr_accessible :name
end
