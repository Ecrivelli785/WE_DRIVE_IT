class DriverRequirementController < ApplicationController
  def index
    @driver_requirements = policy_scope(Driver_requirement).order(created_at: :desc)
  end
end
