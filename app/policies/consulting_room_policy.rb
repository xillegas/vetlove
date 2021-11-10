class ConsultingRoomPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.is_vet
  end

  def update?
    user.is_vet
  end

  def destroy?
    user.is_vet
  end

  def index_vet?
    user.is_vet
  end

  def index_user?
    !user.is_vet
  end
end
