require 'faker'

puts "Reset data"

ActiveRecord::Base.connection.reset_pk_sequence!('tweets')
ActiveRecord::Base.connection.reset_pk_sequence!('likes')
ActiveRecord::Base.connection.reset_pk_sequence!('users')

Tweet.destroy_all
Like.destroy_all
User.destroy_all

puts "Start seeding"

# Crear usuarios
admin = User.create!(
  email: "admin@mail.com",
  username: "admin",
  name: "Admin User",
  password: "supersecret",
  role: 1
)

users = []
4.times do |i|
  user = User.create!(
    name: "Member User #{i+1}",
    username: "member#{i+1}",
    email: "member#{i+1}@example.com",
    password: "password",
    role: 0
  )

  users << user
end

# Crear tweets
users.each do |user|
  5.times do |j|
    tweet = user.tweets.create!(
      body: "This is tweet #{j+1} from #{user.username}",
      replies_count: 0,
      likes_count: 0
    )

    # Reply to other tweets
    if j > 0
      replied_to_tweet = user.tweets.offset(rand(j)).first
      tweet.update!(replied_to: replied_to_tweet)
      replied_to_tweet.increment!(:replies_count)
    end
  end
end

# Crear likes
users.each do |user|
  tweets = user.tweets
  other_users = users - [user]
  tweets.each do |tweet|
    rand(1..3).times do
      other_user = other_users.sample
      like = tweet.likes.create!(user: other_user)
      like.user = admin if rand(0..10) == 0 # Admin likes some tweets randomly
      like.save
    end
  end
end

# Follow other users
users.each do |user|
  other_users = users - [user]
  other_users.sample(rand(1..3)).each do |other_user|
    unless user.following?(other_user)
      user.follow!(other_user)
    end
  end
end