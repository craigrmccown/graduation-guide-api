# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def create(model, data)
  model.create! data unless model.exists? data[:id]
end

create Role, id: 0, name: 'admin'
create Role, id: 1, name: 'student'
