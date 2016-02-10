class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    if user.has_role? Role[:admin]
        can :manage, :all
    end

    if user.has_role? Role[:student]
    end 
  end
end
