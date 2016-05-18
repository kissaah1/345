# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
# cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
# Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name: "Batman",
	email: "masaaki@hugehood.co",
	password: "password",
	password_confirmation: "password",
	admin: true,
	activated: true,
	activated_at: Time.zone.now)

User.create!(name: "Victoria Woo",
	email: "vic@kissaah.com",
	password: "password",
	password_confirmation: "password",
	admin: true,
	activated: true,
	activated_at: Time.zone.now)

29.times do |n|
		name = Faker::Name.name
		email = "user#{n+1}@hugehood.co"
		password = "password"
		User.create!(name: name,
			email: email,
			password: password,
			password_confirmation: password,
			activated: true,
			activated_at: Time.zone.now)
end

# users = User.order(:created_at).take(6)
# 10.times do
# 	content = Faker::Lorem.sentence(5)
# 	users.each { |user| user.microposts.create!(content: content) }
# end

# Following relationships
users = User.all
user  = users.first
following = users[2..20]
followers = users[3..10]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }