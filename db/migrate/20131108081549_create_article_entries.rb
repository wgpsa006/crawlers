class CreateArticleEntries < ActiveRecord::Migration
  def change
    create_table :article_entries do |t|
      t.string :title
      t.text :url

      t.timestamps
    end
  end
end
