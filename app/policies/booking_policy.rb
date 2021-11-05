class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    !user.is_vet
  end

  def create?
    !user.is_vet
  end

end
