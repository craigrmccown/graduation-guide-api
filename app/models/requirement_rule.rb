class RequirementRule < ActiveRecord::Base
  # TODO use polymorphism

  attr_reader :relevant_courses
  attr_accessor :num_courses
  attr_accessor :num_hours
  attr_accessor :course_completed
  attr_accessor :num_any

  belongs_to :course_group, autosave: false
  belongs_to :course, autosave: false
  belongs_to :requirement, autosave: false
  has_many :courses, through: :course_group

  after_initialize do |rule|
    rule.num_courses = 0
    rule.num_hours = 0
    rule.course_completed = false
    rule.num_any = 0
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
    applies = self.courses.include? course
    @num_courses += 1 if applies
    applies
  end

  def evaluate_hours!(course)
    applies = self.courses.include? course
    @num_hours += course.hours if applies
    applies
  end

  def evaluate_course!(course)
    applies = self.course.eql? course
    @course_completed = applies
    applies
  end

  def evaluate_any!(course)
    @num_any += 1
    true
  end
end
