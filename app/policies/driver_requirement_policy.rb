class DriverRequirementPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new
    return true
  end

  def create?
    return true
  end

  def update?
    true
    # record.user == user
  end

  def show?
    return true
  end

  def destroy?
    record.user == user
  end
end
