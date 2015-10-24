# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

PASSWORD = "1234567890"

def seed_photo(name)
	File.new("#{Rails.root}/db/photos/#{name}.jpg")
end

alice = User.create!(
	name: "alice", 
	email: "alice@test.com", 
	first_name: "Alice", 
	last_name: "Test", 
	bio: "Alice NYC-based photographer Twitter/Snapchat: @alice_gao Tinker Street * lingeredupon.blogspot.com", 
	password: PASSWORD, 
	password_confirmation: PASSWORD
)

natgeo = User.create!(
	name: "natgeo",
	email: "nat@geo.com",
	first_name: "National",
	last_name: "Geographic",
	bio: "Magazine", 
	password: PASSWORD, 
	password_confirmation: PASSWORD
)

andrey = User.create!(
	name: "andrey", 
	email: "andrey@test.com",
	first_name: "Andrey",
	last_name: "Kolbasov",
	bio: "Classified",
	password: PASSWORD,
	password_confirmation: PASSWORD
)

test_user = User.create!(
	name: "test", 
	email: "test@user.com",
	first_name: "Test",
	last_name: "User",
	bio: "Test User",
	password: PASSWORD,
	password_confirmation: PASSWORD
)

p1 = alice.photos.create!(file: seed_photo("1"), title: "In which I discuss shoe sizing and @everlane's fun new initiative -- on the blog today")
p2 = alice.photos.create!(file: seed_photo("2"), title: "I've missed enjoying this little corner of my apartment")

p3 = natgeo.photos.create!(file: seed_photo("3"), title: "Happy Feet tearing it up in Antarctica. An emperor penguin chick races towards its parent to be fed a fresh meal from the sea. Photo by @paulnicklen for @natgeo #follow me to see the moment it got a huge mouthful of food. With @sea_legacy #nature #wildlife #explore #gratitude #picoftheday #photooftheday #smile #love #beauty #amazing #instamood #awesome #friends #nofilter #instafollow #202020")
p4 = natgeo.photos.create!(file: seed_photo("4"), title: "photo by @joelsartore | Check out this bashful Andean porcupine from the @stlzoo. Porcupines are good climbers and they like to eat bark (look at those teeth!), so they spend a lot of time in trees. And contrary to popular belief, they cannot shoot their quills at predators. The quills just stand up when a porcupine feels threatened. #Follow me, @joelsartore, to see more of my recent work. #PhotoArk #joelsartore #photooftheday")

p1.comments.create!(text: "Awesome", user: andrey)
p3.comments.create!(text: "Yay!", user: andrey)
p3.comments.create!(text: "Lovely <3", user: alice)
