# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
# cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
# Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name: "Masaaki Furuki",
	email: "masaakifuruki@gmail.com",
	password: "password",
	password_confirmation: "password",
	admin: true,
	activated: true,
	provider: "linkedin"
	uid: "MGcDZdUifE"
	activated_at: Time.zone.now,
	location: "San Francisco Bay Area",
	industry: "Information Technology and Services",
	headline: "Entrepreneur, Designer, Web Developer",
	linkedin: "https://www.linkedin.com/in/masaakifuruki",
	summary: "I'm an entrepreneur, product manager, designer who code. I’ve started my career as a web designer at a creative agency in Tokyo, mid-2000’ and experienced transition from HTML4 to XHTML and HTML5 through browser wars. I also worked at mobile social network site company during a transition of feature phone to a smartphone as well. I’ve experienced business development and promotion in a mobile site publisher. After I had experienced Office 365 Support Engineer at Microsoft Japan, I’ve left Japan and moved to San Francisco for the discovery.",
	skills: "Karate Voice Acting HTML CSS Investment Problem Solving",
	other_skills: "Ruby on Rails Ruby Coding",
	cadmin: true,
	picture: "https://media.licdn.com/mpr/mpr/shrinknp_200_200/AAEAAQAAAAAAAAV4AAAAJDEwYTEwZTgwLTg0MTQtNDQxMC05N2UwLTk5NGIxYTU4OGQwNw.jpg"
	)

User.create!(name: "Victoria Woo, Ph.D.",
	email: "vic@victoriaw.com", 
	admin: true,
	activated: true,
	provider: "linkedin",
	uid: "2FcHD2O4mc",
	location: "San Francisco Bay Area, US",
	industry: "Education Management",
	headline: "Designing thriving transitional experiences in the...",
	linkedin: "https://www.linkedin.com/in/victoriawoo",
	summary: "Entrepreneurial spirited professional with broad skills in start-ups, international business development, and bridging academia with business communities. I am passionate about helping individuals harness the power of their awesome story to connect with their authentic selves, their purpose and meaning i propel flourishing communities and organizations",
	skills: "Start-ups Business Development Entrepreneurship Management Business Strategy Management Consulting Program Management Consulting Strategy Private Equity",
	other_skills: "Leadership Strategic Planning CRM Strategic Partnerships Executive Coaching Integration",
	cadmin: true,
	picture: "https://media.licdn.com/media/p/8/005/017/03a/1a517dc.jpg"
	)

29.times do |n|
		name = Faker::Name.name
		email = "user#{n+1}@hugehood.co"
		location = Faker::Address.city
		industry = Faker::Company.bs
		headline = Faker::Name.title
		summary = Faker::Lorem.paragraph
		skills = Faker::Lorem.sentence
		other_skills = Faker::Lorem.sentence
		User.create!(name: name,
			email: email,
			password: :password_digest,
			password_confirmation: :password_digest,
			activated: true,
			activated_at: Time.zone.now,
			location: location,
			industry: industry,
			headline: headline,
			summary: summary,
			skills: skills,
			other_skills: other_skills,
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