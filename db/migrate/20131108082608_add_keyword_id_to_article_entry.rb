class AddKeywordIdToArticleEntry < ActiveRecord::Migration
  def change
    add_column :article_entries, :keyword_id, :integer
  end
end
