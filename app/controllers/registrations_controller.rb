class RegistrationsController < Devise::RegistrationsController

  def new
    resource_name = :user
    @car = Car.new
    @user = User.new
  end

  protected

  def after_sign_up_path_for(resource)
    if request.path == "/users" && current_user.role == "driver"
      return questions_url
    end

    stored_location_for(resource) || root_path
  end
end
