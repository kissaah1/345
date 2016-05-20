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
	activated_at: Time.zone.now,
	location: "Gothan City, New York",
	industry: "Pacekeeping",
	headline: "Billionaire, Bruce Wayne, Single, Celebrity, I am Batman.",
	summary: "I am Batman. I am Batman. I am Batman. I am Batman. I am Batman. I am Batman. I am Batman. I am Batman.",
	skills: "Karate Voice Acting HTML CSS Investment Problem Solving",
	other_skills: "Ruby on Rails Ruby Coding",
	enthusiast: true,
	skeptic: true,
	navigator: true,
	pioneer: true,
	coach: true,
	solo: true
	)

User.create!(name: "Masaaki Furuki",
	email: "masaakifuruki@me.com",
	password: "password",
	password_confirmation: "password",
	admin: false,
	activated: true,
	activated_at: Time.zone.now,
	location: "San Francisco Bay Area",
	industry: "Internet",
	headline: "Watch your six! Headsup! Sniper! Nice shot! Negative! Cover me I'm reloading!",
	summary: "Tokyo to San Francisco. Lost in transrations. Looking for something better and will.",
	skills: "Video gaming Zen Coding Branding",
	other_skills: "Business Development Writing",
	enthusiast: true
	)

29.times do |n|
		name = Faker::Name.name
		email = "user#{n+1}@hugehood.co"
		password = "password"
		location = Faker::Address.city
		industry = Faker::Company.bs
		headline = Faker::Name.title
		summary = Faker::Lorem.paragraph
		skills = Faker::Lorem.sentence
		other_skills = Faker::Lorem.sentence
		User.create!(name: name,
			email: email,
			password: password,
			password_confirmation: password,
			activated: true,
			activated_at: Time.zone.now,
			location: location,
			industry: industry,
			headline: headline,
			summary: summary,
			skills: skills,
			other_skills: other_skills,
			enthusiast: true,
			skeptic: false,
			navigator: true,
			pioneer: false,
			coach: false
			)
end

users = User.order(:created_at).take(6)
1.times do
	survey_1 = Faker::Lorem.sentence
	survey_2 = Faker::Lorem.sentence
	survey_3 = Faker::Lorem.sentence
	survey_4 = Faker::Number.between(1, 100)
	users.each { |user| user.microposts.create!(survey_1: survey_1, survey_2: survey_2, survey_3: survey_3, survey_4: survey_4) }
end

users = User.order(:created_at).take(6)
3.times do
	title = Faker::Name.title
	summary = Faker::Lorem.sentence
	company = Faker::Company.name
	users.each { |user| user.positions.create!(title: title, summary: summary, company: company, start_date: "2000-01-01", end_date: "2015-05-01") }
end

users = User.order(:created_at).take(6)
3.times do
	name = Faker::Company.name
	industry = Faker::Name.title
	website = Faker::Internet.url
	summary = Faker::Lorem.sentence
	users.each { |user| user.companies.create!(name: name, industry: industry, website: website, summary: summary) }
end


# Following relationships
users = User.all
user  = users.first
following = users[2..20]
followers = users[3..10]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }