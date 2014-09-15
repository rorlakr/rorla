class WelcomeController < ApplicationController
  include MeritHelper
  before_action :resource_refresh  
  def index
  end
end
