# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Project.destroy_all
(1..5).each do |i|
  project = Project.create!(name: "Project #{i}", description: "Project Desc #{i}")
  (1..2).each do |j|
    project.tasks.create!(name: "P#{i}-Task #{j}", description: "P#{i} Desc-Task #{j}")
  end
end
