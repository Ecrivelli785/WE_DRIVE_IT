class DriverRequirementController < ApplicationController
  def index
    @driver_requirements = policy_scope(Driver_requirement).order(created_at: :desc)
  end

  def new
  end

  def create
    @driver_requirement = DriverRequirement.new(user: current_user)
    authorize @driver_requirement

    points = 0
    user_answers = params[:question]

    user_answers.each do | key, value |
      question = Question.find(key.to_i)
      if question.choices.where(correct: true).first.id == value.to_i
        points += 1
      end
    end


    if points >= 2
      @driver_requirement.quiz_certification = true
    else
      @driver_requirement.quiz_certification = false
      flash[:alert] = "Examen reprobado. Por favor trate otra vez."
    end

    if @driver_requirement.save
      redirect_to dashboard_path
    else
      redirect_to questions_path
    end
  end
end
