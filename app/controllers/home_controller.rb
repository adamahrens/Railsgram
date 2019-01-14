class HomeController < ApplicationController
  before_action :authenticate_user!

  def home
    @name = current_user.name
  end
end
