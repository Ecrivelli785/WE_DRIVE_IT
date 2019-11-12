class RidePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    return true
  end

  def create?
    return true
  end

  def update?
    true
    # record.user == user || user.role == "driver"
  end

  def status?
    true
  end
end
