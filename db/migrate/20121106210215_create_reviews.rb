class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :title
      t.string :rating
      t.text :synopsis
      t.date :release
      t.boolean :status
      t.integer :score
      t.float :cost

      t.timestamps
    end
  end
end
