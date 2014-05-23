class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  # def index?  ; false;                            end
  def index?  ; true;                               end

  # def show?   ; scope.where(id: record.id).exists?; end
  def show?   ; record.class;                       end
  def new?    ; create?;                            end
  # def create? ; false;                              end
  def create? ; user.present?                       end
  def edit?   ; update?;                            end
  # def update? ; false;                            end
  def update?
    user.present? && (record.user == user || user.role?(:admin))
  end
  # def destroy?; false;                            end
  def destroy ; update?;                            end

  def scope
    Pundit.policy_scope!(user, record.class)
  end
end

