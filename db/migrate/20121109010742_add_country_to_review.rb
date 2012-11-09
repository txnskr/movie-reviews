class AddCountryToReview < ActiveRecord::Migration 
	def change
		add_column :reviews, :country, :string 
	end
end
