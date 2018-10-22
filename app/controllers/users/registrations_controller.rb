# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  #before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  private

  def account_update_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation,
      :current_password,
      address: [
        :country,
        :zipcode,
        :state,
        :city,
        :street,
        :number
      ]
    )
  end

  def sign_up_params
    params.require(:user).permit(
      :email,
      :taxvat,
      :password,
      :password_confirmation,
      :first_name,
      :last_name
    )
  end
end
