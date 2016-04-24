class Prereq < ActiveRecord::Base
  include JsonSupport

  attr_accessor :children
  attr_accessor :is_satisfied

  json_embed :is_satisfied, :description
  json_exclude :op, :parent_id

  has_and_belongs_to_many :courses

  after_initialize do |prereq|
    prereq.children = []
    prereq.is_satisfied = false
  end

  def evaluate!(courses)
    children.each { |child| child.evaluate! courses }

    if self.op.eql? 'and'
      @is_satisfied = (self.courses - courses).empty? and children.all? { |child| child.satisfied? }
    elsif self.op.eql? 'or'
      @is_satisfied = (self.courses & courses).length > 0 or children.any? { |child| child.satisfied? }
    end
  end

  def description
    child_descriptions = children.inject [] { |descriptions, child| descriptions << child.description }
    self_descriptions = self.courses.inject [] { |descriptions, course| descriptions << course.name }
    result = (self_descriptions + child_descriptions).join " #{self.op.upcase} "

    if self.parent_id.nil?
      result
    else
      "(#{result})"
    end
  end

  alias satisfied? is_satisfied
end
