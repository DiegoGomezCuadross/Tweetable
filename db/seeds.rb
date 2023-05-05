require 'faker'

puts "Reset data"

ActiveRecord::Base.connection.reset_pk_sequence!('tweets')
ActiveRecord::Base.connection.reset_pk_sequence!('likes')
ActiveRecord::Base.connection.reset_pk_sequence!('users')

Tweet.destroy_all
Like.destroy_all
User.destroy_all

puts "Start seeding"
# Admin user
User.create!(
  email: "admin@mail.com",
  username: "admin",
  name: "Admin User",
  password: "supersecret",
  role: 1
)

# Member users
4.times do |i|
  user = User.create!(
    name: "Member User #{i+1}",
    username: "member#{i+1}",
    email: "member#{i+1}@example.com",
    password: "password",
    role: 0
  )

  # Create some tweets for each member
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

    # Like some tweets
    rand(1..3).times do
      tweet.likes.create!(user: User.where.not(id: user.id).order(Arel.sql("RANDOM()")).first)
    end
  end

  # Follow other users
  User.order(Arel.sql("RANDOM()")).limit(rand(1..3)).each do |other_user|
    unless other_user == user || user.following?(other_user)
      user.follow!(other_user)
    end
  end
end