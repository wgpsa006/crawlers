class ArticleEntry < ActiveRecord::Base
  belongs_to :keyword
  has_one :article

  attr_accessible :title, :url, :keyword_id
end
