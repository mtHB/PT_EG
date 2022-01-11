class CalendarEntriesController < ApplicationController
  require 'calendar_helper'

  before_action :pre_action

  def index
    render json: @model.all
  end

  def new
    render json: { "not": 'implemented' }
  end

  def create
    record = CalendarHelper.create_ce(params)
    response = { state: record.errors.empty?, object: record, errors: record.errors }
    render json: response
  end

  def show
    record = @model.find_by(id: params['id'])
    render json: { object: record }
  end

  def update
    record = CalendarHelper.update_ce(params)

    response = if record.nil?
                 nil
               else
                 { state: record.valid?, object: record, errors: record.errors }
               end
    render json: response
  end

  def destroy
    response = { state: CalendarHelper.destroy(params['id']) }
    render json: response
  end

  protected

  def pre_action
    @model = CalendarEntry
  end
end
