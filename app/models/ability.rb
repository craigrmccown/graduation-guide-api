class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    if user.has_role? Role[:admin]
      can :manage, :all
    end

    if user.has_role? Role[:student]
      can :whoami, User
      can :add_majors, User
      can :add_minors, User
      can :get_all, Major
      can :get_all, Minor
    end 
  end
end
