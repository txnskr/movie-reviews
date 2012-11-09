class Review < ActiveRecord::Base
  attr_accessible :cost, :rating, :release, :score, :status, :synopsis, :title, :image, :country
  
  after_save :store_image
  
  validates_presence_of :title
  validates_presence_of :rating, :message => "is neccessary just like food and water!"
  validates_numericality_of :score, :greater_than => 0, :less_than_or_equal_to => 10, :on => "create"
  validates_presence_of :synopsis, :if => :movie_is_g_or_pg?, :message => "required for G or PG"
  validates_length_of :synopsis, :maximum => 0, :if => :movie_is_x?, :message => "Naughty Naughty"
  
  IMAGE_STORE = "#{Rails.root}/public/image_store"
  
  RATINGS = {
    "G" => "General Admission",
    "PG" => "Parental Guidance",
    "R" => "Restricted",
    "X" => "Adults Only"
  }

  

  def movie_is_g_or_pg?
    if self.rating == "General Admission" ||
      self.rating == "Parental Guidance"
        true
    else
      false
    end
  end

  def movie_is_x?
  	# Rails.logger.info "*"*88
  	# Rails.logger.info self.rating
  	# Rails.logger.info "*"*88
  	if self.rating == "Adults Only"
  		true
  	else
  		false
  	end
  end

  def image_filename
    return "#{IMAGE_STORE}/#{id}.#{image_type}"
  end

  # at upload assign file_data to instance var and grab image type 
  def image=(file_data)
    unless file_data.blank?
    # assign uploaded data to instance variable
      @file_data = file_data
    # assign image type (extension) to self.image_type
      self.image_type = file_data.original_filename.split('.').last.downcase
     end 
  end
  # define method to retrieve relative URI for the stored image # in the /public directory of the app, for use in HTML
  def image_uri
    return "/image_store/#{id}.#{image_type}"
  end
# define method to determine if a review has an image on the # file system at the location specified by image_filename 
  def has_image?
    return File.exists? image_filename 
  end

  private
  def store_image
   if @file_data
      # create directory at IMAGE_STORE if it does not exist
      FileUtils.mkdir_p IMAGE_STORE
      # save image to file location and name from image_filename method 
      File.open(image_filename, 'wb') do |f|
        f.write(@file_data.read) 
      end
      # nil file_data in memory so it won't be resaved
      @file_data = nil 
    end
  end
end



