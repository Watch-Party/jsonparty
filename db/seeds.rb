# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.new(screen_name: "Jason Jordan", email: "jj@example.com", password: "hunter2")
user1.save(:validate => false)

user2 = User.new(screen_name: "Aaron", email: "an@example.com", password: "hunter2")
user2.save(:validate => false)

show1 = Show.new(title: "Awesome Show", summary: "This is a really great show!")
show1.save

season1 = show1.seasons.new(season_number: 4)
season1.save

episode1 = season1.episodes.new(title: "Let the show begin")
episode1.save(:validate => false)

post1 = episode1.posts.new(user: user1, episode: episode1, content: "Did you just see that?", time_in_episode: 500)
post1.save
