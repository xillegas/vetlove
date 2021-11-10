class PetPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    !user.is_vet
  end

  def show?
    !user.is_vet
  end

  def create?
    !user.is_vet
  end

  def update?
    !user.is_vet
  end

  def destroy?
    !user.is_vet
  end
end
