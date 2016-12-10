class Category < ApplicationRecord
  has_many :recipe_categories
  has_many :recipes, through: :recipe_categories

  has_attached_file :image, styles: { :medium => "400x400#" }
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
