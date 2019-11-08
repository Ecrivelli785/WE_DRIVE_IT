class PaymentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    return true
  end

  def add_card?
    return true
  end

  def add_payment?
    return true
  end

  def make_payment?
    return true
  end
end
