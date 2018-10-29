# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  def new
    @address = Address.new
    super
  end

  def edit
    @address = resource.address || Address.new
    super
  end

  def drugstore_register_new
    @address = Address.new
    @minimum_password_length = 6
    build_resource
    yield resource if block_given?
    respond_with resource
  end

  def drugstore_register_create
    build_resource(sign_up_params)

    resource.add_role :drugstore
    resource.save
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        redirect_to root_path
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!  redirect_to root_path
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      redirect_to drugstores_sign_up_path
    end
  end

  private

  def account_update_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation,
      :current_password,
      address_attributes: [
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
      :last_name,
      address_attributes: [
        :country,
        :zipcode,
        :state,
        :city,
        :street,
        :number
      ]
    )
  end
end
