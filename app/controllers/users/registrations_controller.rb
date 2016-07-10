class Users::RegistrationsController < Devise::RegistrationsController

  def create
   if !verify_recaptcha
      flash.delete :recaptcha_error
      build_resource(sign_up_params)
      resource.valid?
      resource.errors.add(:base, "There was an error with the recaptcha code below. Please re-enter the code.")
      clean_up_passwords(resource)
      respond_with_navigational(resource) { render_with_scope :new }
    else
      flash.delete :recaptcha_error
      @user = build_resource # Needed for Merit
      super
    end
  end

  def update
    @user = resource # Needed for Merit
    super
  end
end
