class Label < ActiveRecord::Base
    belongs_to :session, inverse_of: :label
	has_and_belongs_to_many :errands, inverse_of: :label

	validates :name, presence: true, uniqueness: true ,length: {maximum: 25}
end
