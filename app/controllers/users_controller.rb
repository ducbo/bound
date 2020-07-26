class UsersController < ApplicationController

  before_action { @active_nav = :users }

  def index
    @users = User.order(:name).to_a
  end
end
