class Prereq < ActiveRecord::Base
  include JsonSupport

  json_transient :course_ids

  has_and_belongs_to_many :courses

  def course_ids
    query = "
      select course_id
      from courses_prereqs
      where prereq_id = #{self.id}
    "

    results = ActiveRecord::Base.connection.execute query
    results.collect { |result| result['course_id'] }
  end

  def self.build_tree(courses)
    course_ids = courses.collect { |course| course.id }
    query = "
      with recursive prereq_tree as (
        select * from prereqs
        where id = any (array[#{course_ids.join(',')}])
        union all
        select * from prereqs
        join prereq_tree on
          prereqs.parent_id = prereq_tree.id
      )
      select * from prereq_tree
    "

    prereqs = Prereq.find_by_sql query
  end
end
