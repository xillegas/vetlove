class RecordPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    return true
  end

  def create?
    user.is_vet
  end

  def show?
    user.is_vet || !user.is_vet
  end
end
