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
User.destroy_all

slytherin = House.create(name: "Slytherin", founder: "Salazar Slytherin", animal: "Snake", head_professor: "Severus Snape", ghost: "The Bloody Baron" )
gryffindor = House.create(name: "Gryffindor", founder: "Godric Gryffindor", animal: "Lion", head_professor: "Minera McGonagall", ghost: "Nearly Headless Nick")
ravenclaw = House.create(name: "Ravenclaw", founder: "Rowena Ravenclaw", animal: "Eagle", head_professor: "Filius Flitwick", ghost: "The Grey Lady")
hufflepuff = House.create(name: "Hufflepuff", founder: "Helga Hufflepuff", animal: "Badger", head_professor: "Pomona Sprout", ghost: "The Fat Friar")

# Game seeds to be commented out later
game1 = Game.create(user_house_id: House.find_by(name: "Gryffindor").id, computer_house_id: House.find_by(name: "Slytherin").id)
game2 = Game.create(user_house_id: slytherin.id, computer_house_id: gryffindor.id)

# Turn seeds to be commented out later
turn1 = Turn.create(game_id: Game.first.id, user_energy: 10, computer_energy: 10, user_score: 0, computer_score: 0, user_bludger_outcome: 0, computer_bludger_outcome: 0, user_snitch_chance: 50, computer_snitch_chance: 0, user_quaffle_allocation: 3, user_bludger_allocation: 1, user_snitch_allocation: 6)
# turn2 = Turn.create(game_id: Game.first.id, user_quaffle_allocation: 3, user_bludger_allocation: 1, user_snitch_allocation: 6)