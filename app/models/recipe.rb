class Recipe < ApplicationRecord
	belongs_to :user

	has_many :ingredients
	has_many :instructions

	accepts_nested_attributes_for :ingredients,
  								reject_if: proc { |attributes| attributes['name'].blank? },
  								allow_destroy: true
 	accepts_nested_attributes_for :instructions,
  								reject_if: proc { |attributes| attributes['step'].blank? },
  								allow_destroy: true

  	validates :name, :description, :image, presence: true

	has_attached_file :image, styles: { :medium => "400x400#" }
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

 def self.search(search)
  where("name LIKE ?", "%#{search}%") 
end
end
