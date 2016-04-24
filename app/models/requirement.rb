class Requirement < ActiveRecord::Base
  # TODO use polymorphism

  include JsonSupport

  attr_accessor :is_satisfied
  attr_accessor :children

  json_embed :is_satisfied, :description, :unsatisfied_description, :courses
  json_exclude :op, :parent_id, :priority

  has_many :requirement_rules
  has_and_belongs_to_many :majors
  has_and_belongs_to_many :tracks
  has_and_belongs_to_many :minors

  after_initialize do |requirement|
    requirement.children = []
    requirement.is_satisfied = false
  end

  def <=>(node)
    self.priority <=> node.priority
  end

  def nodes
    @nodes ||= (@children + self.requirement_rules).sort
  end

  def description
    describe(nodes)
  end

  def unsatisfied_description
    unless satisfied?
      unsatisfied = nodes.select { |node| not node.satisfied? }
      describe(unsatisfied)
    end
  end

  def courses
    rule_courses = self.requirement_rules.inject [] { |courses, rule| courses + rule.relevant_courses }
    child_courses = @children.inject [] { |courses, child| courses + child.courses }
    rule_courses + child_courses.uniq
  end

  def evaluate!(course)
    unsatisfied = nodes.select { |node| not node.satisfied? }

    if self.op == 'and'
      unsatisfied.each do |node|
        node.evaluate! course
        break if node.satisfied?
      end

      @is_satisfied = nodes.all? { |node| node.satisfied? } 
    elsif self.op == 'or'
      unsatisfied.each { |node| node.evaluate! course }
      @is_satisfied = nodes.any? { |node| node.satisfied? } 
    end
  end

  alias satisfied? is_satisfied

  private

  def describe(nodes)
    descriptions = nodes.inject [] { |descriptions, node| descriptions << node.description }
    result = descriptions.join " #{self.op.upcase} "
    
    if parent_id.nil?
      result
    else
      "(#{result})"
    end
  end
end
