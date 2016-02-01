class Label < ActiveRecord::Base
	has_and_belongs_to_many :errands, inverse_of: :label
end
