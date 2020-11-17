# frozen_string_literal: true

class AddCounterToUrls < ActiveRecord::Migration[5.0]
  def change
    add_column :urls, :counter, :integer, null: false, default: 0
  end
end
