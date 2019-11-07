class QuestionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @questions = policy_scope(Question).order('RANDOM()').limit(10)
  end
end
