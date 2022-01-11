module CalendarHelper
  RANGES = { 'week' => 1.week, 'month' => 1.month, 'quarter' => 3.month }
  def self.update_ce(params)
    record = CalendarEntry.find_by(id: params['id'])
    unless record.nil?
      record.start_date = params['start_date'].to_date.beginning_of_day unless params['start_date'].nil?
      record.end_date = params['end_date'].to_date.end_of_day unless params['end_date'].nil?
      record.state = params['state'] unless params['state'].nil?
      record.save
    end
    record
  end

  def self.create_ce(params)
    start_date = params['start_date'].to_date
    end_date = params['end_date'].to_date

    record = CalendarEntry.create(user_id: params['user_id'],
                                  start_date: start_date.beginning_of_day,
                                  end_date: end_date.end_of_day,
                                  state: params['state'])
  end

  def self.user_available(start_date, end_date, user_id)
    ce = CalendarEntry.create(user_id: user_id, start_date: start_date, end_date: end_date, state: 0)
    ce.valid?
  end

  def self.get_entries(user_id, start_date, end_date, range)
    user_entries = CalendarEntry.of_user(user_id)

    if start_date && end_date
      entries = user_entries.between(start_date.to_datetime, end_date.to_datetime)
    elsif range
      time_range_to_add = RANGES[range]
      entries = user_entries.between(Date.today, Date.today + time_range_to_add)
    else
      entries = user_entries.thirty_days
    end
    
    entries
  end

  def self.destroy(id)
    record = CalendarEntry.find_by(id: id)
    if record.nil?
      state = false
    else
      state = true
      record.destroy
    end
    state
  end
end
