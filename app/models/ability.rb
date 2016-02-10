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
      can :add_tracks, User
      can :get_all, Major
      can :get_all, Minor
      can :get_by_major, Track
      can :get_all_for_user, Course
    end 
  end
end
