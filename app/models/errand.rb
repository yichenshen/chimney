class Errand < ActiveRecord::Base
	has_and_belongs_to_many :labels, inverse_of: :errand
	validates :title, presence: true, length: {maximum: 100}

	attr_accessor :status
end
