class Requirement < ActiveRecord::Base
  include JsonSupport

  json_embed :is_satisfied, :courses
  json_ignore :op

  has_many :requirement_rules

  def children
    @children ||= []
  end

  def courses
    rule_courses = self.requirement_rules.inject([]) { |courses, rule| courses + rule.relevant_courses }
    child_courses = @children.inject([]) { |courses, child| courses + child.courses }
    rule_courses + child_courses
  end

  def load!(courses)
    courses.each do |course|
      self.requirement_rules.each { |rule| rule.load! course }
    end

    @children.each do |child|
      child.load! courses
    end
  end
  
  def evaluate!(course)
    @children.any? { |child| child.evaluate! } or self.requirement_rules.any? { |rule| rule.evaluate course }
  end

  def satisfied?
    if self.op == 'and'
      @children.all? { |child| child.satisfied? } and self.requirement_rules.all? { |rule| rule.satisfied? }
    elsif self.op == 'or'
      @children.any? { |child| child.satisfied? } or self.requirement_rules.any? { |rule| rule.satisfied? }
    else
      false
    end
  end

  alias :satisfied? :is_satisfied
end
