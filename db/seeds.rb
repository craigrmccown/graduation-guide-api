require "#{Rails.root}/lib/grouch"
require 'json'

# Inserts model if it doesn't already exist
def safe_create(model)
  if model.class.exists? model.id
    model.class.find model.id
  else
    model.save!
  end

  model
end

# Create static data
role_admin = safe_create Role.new(id: 0, name: 'admin')
role_student = safe_create Role.new(id: 1, name: 'student')
major_cs = safe_create Major.new(id: 0, name: 'Computer Science', description: 'Georgia Tech computer science major')
