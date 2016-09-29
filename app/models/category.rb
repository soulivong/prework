class Category < ActiveRecord::Base
	has_many :posts

	validates_presence_of :name, :message => "please enter Category name"
end

