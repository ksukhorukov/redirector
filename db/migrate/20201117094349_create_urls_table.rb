class CreateUrlsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :urls do |t|
    	t.string :url, null: false
    	t.string :short_url, null: false
    	t.index :short_url
    	t.timestamps
    end


  end
end
