# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

House.destroy_all
Game.destroy_all
Turn.destroy_all

slytherin = House.create(name: "Slytherin")
gryffindor = House.create(name: "Gryffindor")
ravenclaw = House.create(name: "Ravenclaw")
hufflepuff = House.create(name: "Hufflepuff")

# Game seeds to be commented out later
game1 = Game.create(user_house_id: House.find_by(name: "Gryffindor").id, computer_house_id: House.find_by(name: "Slytherin").id)
game2 = Game.create(user_house_id: slytherin.id, computer_house_id: gryffindor.id)

# Turn seeds to be commented out later
turn1 = Turn.create(game_id: Game.first.id, user_energy: 1, computer_energy: 1, user_score: 1, computer_score: 1, user_bludger_outcome: 1, computer_bludger_outcome: 1, user_snitch_chance: 1, computer_snitch_chance: 1)
turn2 = Turn.create(game_id: Game.first.id)