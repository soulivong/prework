class Post < ActiveRecord::Base
	belongs_to :category
	has_many :comments, :dependent => :destroy

	validates_presence_of :title, :message => "Title cannot be blank"
	validates_presence_of :category_id, :message => "Please choose category or create a new category"

	def self.search(search)
  		where("title ILIKE ? OR body ILIKE ?", "%#{search}%", "%#{search}%") 
	end	
end
