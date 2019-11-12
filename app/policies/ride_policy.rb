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
    record.user == user || record.driver_id = user.id
  end

  def status?
    true
  end
end
