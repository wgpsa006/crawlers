class AddArticleEntryIdToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :article_entry_id, :integer
  end
end
