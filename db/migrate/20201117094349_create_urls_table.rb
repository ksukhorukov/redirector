class CreateUrlsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :urls do |t|
    	t.string :url, null: false
    	t.string :key, null: false
    	t.index :key
    	t.timestamps
    end


  end
end
