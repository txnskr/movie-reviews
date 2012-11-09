class CustomFormBuilder < ActionView::Helpers::FormBuilder 

	def create_countries_array 
		@countries = Array.new
		@countries.push(["Australia","Australia"]) 
		@countries.push(["Canada","Canada"])
		@countries.push(["Russia", "Russia"])
		@countries.push(["United Kingdom","United Kingdom"]) 
		@countries.push(["United States of America","United States of America"])
	end
	def country_select(method, options={}, html_options={}) 
		create_countries_array
		select(method, @countries, options, html_options) 
	end

	def label(method, options={}, html_options={}) 
		html_to_add = ""
		if options[:required]
			html_to_add = "<span class='asterik'>*</span>"
		end
		super(method, options) + html_to_add.html_safe 
	end

end
