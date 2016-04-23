class RequirementRule < ActiveRecord::Base
  # TODO use polymorphism

  attr_reader :relevant_courses

  belongs_to :course_group
  belongs_to :course
  has_many :courses, through: :course_group

  def load!(course)
    @relevant_courses = [] if @relevant_courses.nil?

    if self.rule_type.eql? 'courses'
      @relevant_courses << course if self.courses.include? relevant_courses
    elsif self.rule_type.eql? 'hours'
      @relevant_courses << course if self.courses.include? relevant_courses
    end
  end

  def evaluate!(course)
    @is_satisfied = false if @is_satisfied.nil?
    @num_courses = 0 if @num_courses.nil?
    @num_hours = 0 if @num_hours.nil?
    @course_completed = false if @course_completed.nil?
    @num_any = 0 if @num_any.nil?

    if self.rule_type.eql? 'courses'
      evaluate_courses! course
    elsif self.rule_type.eql? 'hours'
      evaluate_hours! course
    elsif self.rule_type.eql? 'course'
      evaluate_course! course
    elsif self.rule_type.eql? 'any'
      evaluate_any! course
    else
      false
    end
  end

  def satisfied?
    if self.rule_type.eql? 'courses'
      @num_courses == self.quantity
    elsif self.rule_type.eql? 'hours'
      @num_hours == self.quantity
    elsif self.rule_type.eql? 'course'
      @course_completed
    elsif self.rule_type.eql? 'any'
      @num_any == self.quantity
    else
      false
    end
  end

  private

  def evaluate_courses!(course)
    is_relevant = @relevant_courses.include? course
    @num_courses += 1 if is_relevant
    is_relevant
  end

  def evaluate_hours!(course)
    is_relevant = @relevant_courses.include? course
    @num_hours += course.hours if is_relevant
    is_relevant
  end

  def evaluate_course!(course)
    @course_completed = self.course.eql? course
  end

  def evaluate_any!(course)
    @num_any += 1
  end
end
