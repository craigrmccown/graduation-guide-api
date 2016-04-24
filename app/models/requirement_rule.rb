class RequirementRule < ActiveRecord::Base
  # TODO use polymorphism

  attr_reader :relevant_courses

  belongs_to :course_group, autosave: false
  belongs_to :course, autosave: false
  belongs_to :requirement, autosave: false
  has_many :courses, through: :course_group

  def after_initialize
    @is_satisfied = false
    @num_courses = 0
    @num_hours = 0
    @course_completed = false
    @num_any = 0
  end

  def <=>(node)
    self.priority <=> node.priority
  end

  def evaluate!(course)
    if self.rule_type.eql? 'courses'
      evaluate_courses! course
    elsif self.rule_type.eql? 'hours'
      evaluate_hours! course
    elsif self.rule_type.eql? 'course'
      evaluate_course! course
    elsif self.rule_type.eql? 'any'
      evaluate_any! course
    end
  end

  def satisfied?
    if self.rule_type.eql? 'courses'
      @num_courses >= self.quantity
    elsif self.rule_type.eql? 'hours'
      @num_hours >= self.quantity
    elsif self.rule_type.eql? 'course'
      @course_completed
    elsif self.rule_type.eql? 'any'
      @num_any >= self.quantity
    end
  end

  def relevant_courses
    if ['courses', 'hours'].include? self.rule_type
      self.courses
    elsif self.rule_type.eql? 'course'
      [self.course]
    elsif self.rule_type.eql? 'any'
      Course.all
    else
      []
    end
  end

  private

  def evaluate_courses!(course)
    @num_courses += 1 if self.courses.include? course
  end

  def evaluate_hours!(course)
    @num_hours += course.hours if self.courses.include? course
  end

  def evaluate_course!(course)
    @course_completed = self.course.eql? course
  end

  def evaluate_any!(course)
    @num_any += 1
  end
end
