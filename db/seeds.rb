require 'faker'

puts "Reset data"

Like.destroy_all
Tweet.destroy_all
User.destroy_all


ActiveRecord::Base.connection.reset_pk_sequence!('likes')
ActiveRecord::Base.connection.reset_pk_sequence!('tweets')
ActiveRecord::Base.connection.reset_pk_sequence!('users')


puts "Seeding User Admin"

User.create(email: "admin@mail.com",
            username: "Boss", 
            name: "admin", 
            password: "supersecret",
            role: 1
            )

puts "Seeding Users Members"

4.times do
    user = User.new(email: Faker::Internet.email, 
                    username: Faker::Internet.username, 
                    name: Faker::Name.name,
                    role: 0, 
                    password:"querty"
                    )
    if user.valid?
        user.save
    else
        p user.errors.full_messages
    end
end

puts "Seeding Tweets"

5.times do
    tweet = Tweet.new(user: User.all.sample,
                      body: Faker::Hipster.paragraph_by_chars(characters: 139)
                     )
    if tweet.valid?
        tweet.save
    else
        p tweet.errors.full_messages
    end
end

puts "Seeding replied to Tweets"

created_tweets = Tweet.all
10.times do
    retweet = Tweet.new(user: User.all.sample, 
                        body: Faker::Hipster.paragraph_by_chars(characters: 139), 
                        replied_to: created_tweets.sample )
    if retweet.valid?
        retweet.save
    else
        p retweet.errors.full_messages
    end
end

puts "Seeding likes Tweets"

10.times do
    like = Like.new(user: User.all.sample,
                    tweet: Tweet.all.sample
                   )
    if like.valid?
        like.save
    else
        p like.errors.full_messages
    end
end

puts "Completed"