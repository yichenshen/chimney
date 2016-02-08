class Errand < ActiveRecord::Base
    belongs_to :session, inverse_of: :errands
	has_and_belongs_to_many :labels, inverse_of: :errand

	validates :title, presence: true, length: {maximum: 100}

    scope :not_done, -> {where(done: false)}
    scope :due, ->{not_done.where.not(deadline: nil).order(:deadline, :created_at)}
    scope :no_due, -> {not_done.where(deadline: nil).order(:created_at)}
    scope :done, -> {where(done: true).order(:created_at)}
    scope :match_string, ->(term) { where("title LIKE (?) OR content LIKE (?)", "%" + term + "%", "%" + term + "%")}

    attr_accessor :status

    after_initialize :set_status

    def toggle_state
        self.done = !self.done
    end

    def set_status
        if self.done
            self.status = :done
        elsif self.deadline and self.deadline < Date.today
            self.status = :late
        elsif self.deadline and self.deadline == Date.today
            self.status = :due_today
        else
            self.status = :not_due
        end
    end
end
