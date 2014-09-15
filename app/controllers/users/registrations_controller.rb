class Users::RegistrationsController < Devise::RegistrationsController
  def create
    @user = build_resource # Needed for Merit
    super
  end

  def update
    @user = resource # Needed for Merit
    super
  end
end
