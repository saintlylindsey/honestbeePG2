class User < ApplicationRecord
	include UniqueTokenGenerator

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :recipes
	has_many :reviews, dependent: :destroy
  has_attached_file :image, styles: { :medium => "400x400#" }
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

	before_save :ensure_authentication_token

	private

	def ensure_authentication_token
		generate_token_for :authentication_token, token_size: 16
	end

end
