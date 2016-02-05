class Label < ActiveRecord::Base
	has_and_belongs_to_many :errands, inverse_of: :label
	validates :name, presence: true, uniqueness: true ,length: {maximum: 25}
end
