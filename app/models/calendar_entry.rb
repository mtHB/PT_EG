class CalendarEntry < ApplicationRecord
  validate :no_change_on_booked_state, on: :update
  validate :no_state_conflict
  validates :start_date, comparison: { less_than_or_equal_to: :end_date }
  validates :user_id, presence: true
  validates :state, presence: true

  scope :of_user, ->(user_id) { where(user_id: user_id) }
  scope :between, lambda { |start_date, end_date|
                    where('(start_date >= ? AND end_date <= ?)', start_date.beginning_of_day, end_date.end_of_day)
                  }
  scope :thirty_days, -> { between(Date.today.beginning_of_day, (Date.today.end_of_day + 1.month)) }

  private

  def no_state_conflict
    conflicting_entries = CalendarEntry.of_user(user_id).where.not(id: id).between(start_date, end_date)
    # booked entries
    conflicting_entries.each do |entry|
      if entry.state == 2
        errors.add(:state,
                   "Due to an booked entry, no further entries possible between #{start_date} and #{end_date}") and return
      end
    end

    # tentative entires
    if state == 1 && (conflicting_entries.length > 4)
      errors.add(:state,
                 'Tentative entry conflicts with more than 4 other entries.')
    end
  end

  def no_change_on_booked_state
    errors.add(:state, 'Calendar entry is already booked! No state update allowed.') if state_was == 2 && state_changed?
  end
end
