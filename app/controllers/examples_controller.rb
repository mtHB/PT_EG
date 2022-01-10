class ExamplesController < ApplicationController
  before_action :pre_action
  #### Resources actions

  def index
    render json: { 'hello': 'world' }
  end

  def new
    render json: {action: "new"}
  end

  def create
    render json: {action: "create"}
  end

  def show
    render 
  end

  def edit; end

  def update; end

  def destroy; end

  #### Resources actions

  protected

  def pre_action
    @model = Example
  end
end
