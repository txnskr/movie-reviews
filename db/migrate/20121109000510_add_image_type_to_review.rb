class AddImageTypeToReview < ActiveRecord::Migration
	def change
		add_column :reviews, :image_type, :string
	end
end
