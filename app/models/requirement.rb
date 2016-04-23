class Requirement < ActiveRecord::Base
  include JsonSupport

  json_embed :requirement_rules

  def requirement_rules
    query = "
      with recursive rule_tree as (
        select *
        from requirement_rules
        where requirement_id = #{self.id}
        union all
        select requirement_rules.*
        from requirement_rules
        join rule_tree
          on requirement_rules.parent_id = rule_tree.id
      )
      select * from rule_tree
    "

    RequirementRule.find_by_sql query
  end

  def self.find_by_user(user)
    query = "
      select requirements.*
      from requirements
      join majors
        on requirements.major_id = majors.id
      join majors_users
        on majors.id = majors_users.major_id
      where majors_users.user_id = #{user.id}
      union
      select requirements.*
      from requirements
      join tracks
        on requirements.track_id = tracks.id
      join tracks_users
        on tracks.id = tracks_users.track_id
      where tracks_users.user_id = #{user.id}
      union
      select requirements.*
      from requirements
      join minors
        on requirements.minor_id = minors.id
      join minors_users
        on minors.id = minors_users.minor_id
      where minors_users.user_id = #{user.id}
    "

    Requirement.find_by_sql query
  end
end
