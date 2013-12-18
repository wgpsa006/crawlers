class AddAuthorizeAtStringToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :authorize_at_string, :string
  end
end
