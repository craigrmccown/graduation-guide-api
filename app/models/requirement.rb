class Requirement < ActiveRecord::Base
  # TODO use polymorphism

  include JsonSupport

  attr_reader :is_satisfied
  attr_reader :children

  json_embed :is_satisfied, :courses
  json_exclude :op

  has_many :requirement_rules
  belongs_to :major, autosave: false
  belongs_to :track, autosave: false
  belongs_to :minor, autosave: false

  def after_initialize
    @children = []
    @is_satisfied = false
  end

  def <=>(node)
    self.priority <=> node.priority
  end

  def nodes
    @nodes ||= (@children + self.requirement_rules).sort
  end

  def courses
    rule_courses = self.requirement_rules.inject([]) { |courses, rule| courses + rule.relevant_courses }
    child_courses = @children.inject([]) { |courses, child| courses + child.courses }
    rule_courses + child_courses
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
end
