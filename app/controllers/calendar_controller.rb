class CalendarController < ApplicationController
  require 'calendar_helper'
  before_action :pre_action

  def user_calendar
    entries = CalendarHelper.get_entries(params['user_id'], params['start_date'], params['end_date'],
                                         params['range'])
    render json: { entries: entries }
  end

  def user_available
    render json: { available: CalendarHelper.user_available(params['start_date'], params['end_date'],
                                                            params['user_id']) }
  end

  private

  def pre_action
    @entries = CalendarEntry
  end
end
