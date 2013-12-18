class Article < ActiveRecord::Base
  belongs_to :article_entry

  attr_accessible :authorize_at, :content, :title, :article_entry_id, :authorize_at_string
end
