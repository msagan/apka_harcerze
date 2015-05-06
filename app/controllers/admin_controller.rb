# coding: UTF-8

# controller: Admin
class AdminController < ApplicationController
  # dashboard only for ':AS' [administrator_systemu]
  before_action :authenticate_admin!
  layout 'admin'

  def index ; end

  private
  def authenticate_admin!
    unless current_user && current_user.admin?
      redirect_to '/', alert: 'Nie masz uprawnień'
      return
    end
    true
  end
end
