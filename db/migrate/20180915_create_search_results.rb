class CreateSearchResults < ActiveRecord::Migration[5.1]
  def change
    create_table :search_results do |t|
      t.string :title
      t.string :url
      t.text :description
      t.timestamps
    end
  end
end
