class QuestionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    # if current_user.present? && current_user.driver_requirement
    #   return redirect_to dashboard_path
    # end
    @questions = policy_scope(Question).order('RANDOM()').limit(3)
    @driver_requirement = DriverRequirement.new(user: current_user)
  end

end
