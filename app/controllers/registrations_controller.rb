class RegistrationsController < Devise::RegistrationsController

  def new
    @car = Car.new
    @user = User.new
    resource_name = :user
  end

  def create
    @user = User.new(user_params)

    if @user.role == "passenger"
      @car = Car.new(car_params)
      if @user.save
        @car.user = @user
        if @car.save
          @ride = Ride.find(session[:ride_id])
          @ride.user = @user
          @ride.save
          sign_in(@user, scope: :user)
          return redirect_to @ride
        else
          @user.destroy
          flash[:alert] = "Please complete all User and Car fields!"
          return redirect_to new_user_registration_path
        end
      else
        @car.valid?
        return render "new"
      end
    else
      if @user.save
        flash[:notice] = "Please answer the Driver quiz!"
        sign_in(@user, scope: :user)
        return redirect_to questions_path
      else
        flash[:alert] = "Please complete all User fields!"
        params[:role] = "driver"
        return render "new"
      end
    end
    flash[:alert] = "Failed to sign up. Please review all User fields!"
    return redirect_to new_user_registration_path
  end

  protected

  def after_sign_up_path_for(resource)
    if request.path == "/users" && current_user.role == "driver"
      return questions_url
    end

    stored_location_for(resource) || root_path
  end

  def user_params
    params.require(:user).permit(:full_name, :birthday, :role, :address, :dni, :city, :photo, :license)
  end

  def car_params
    params.require(:user).require(:car).permit(:brand, :model, :year, :transmission, :plate, :poliza, :green_card, :fuel_type)
  end
end
