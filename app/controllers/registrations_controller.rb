# coding: UTF-8
# controller: custom for devise
class RegistrationsController < Devise::RegistrationsController
  private
  
  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :stars, :description, :pesel, :address_1, :address_2, :school, :parental_agreement, :medical_info, :school_class, :team_id, :email, :password, :password_confirmation)
  end
 
  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :stars, :description, :pesel, :address_1, :address_2, :school, :parental_agreement, :medical_info, :school_class, :team_id, :email, :password, :password_confirmation, :current_password)
  end
end