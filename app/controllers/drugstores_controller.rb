class DrugstoresController < ApplicationController
  def new
    @user = User.new
    @resource_name = 'user'
    render 'new'
  end

  def create
    build_resource(sign_up_params)
    resource.save
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        responde_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      responde_with resource
    end
  end

  def resource
    instance_variable_get(:"@#{@resource_name}")
  end

  protected

  def build_resource(hash = {})
    self.resource = resource_class.new_with_session(hash, session)
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
