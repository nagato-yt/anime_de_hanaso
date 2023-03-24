# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Admin.create!(
   email: ENV['ADMIN_EMAIL'] ,
   password: ENV['ADMIN_PASSWORD'], 
)

1.times do
     require 'csv'
     csv = CSV.read('db/seeds/users.csv')
     csv.each do |user|
     user = User.create!(
        name: user[1],
        email: user[3],
        introduction: user[2],
        password: ENV['USER_PASSWORD']
     )
    puts "\"#{user.name}\" has created!"
  end
end

1.times do 
    require 'csv'
    csv = CSV.read('db/seeds/posts.csv')
    csv.each do |title|
   post = Post.create!(
    title: title[1],
    body: 'このアニメがとても面白かったです！どのキャラクターが一番好きですか？',
    user_id: rand(1..16)
  )
  puts "\"#{post.title}\" has created!"
  end
end

16.times do
    
    relationship = Relationship.create!(
        followed_id: rand(1..16),
        follower_id: rand(1..16)
        )
        puts "\"#{relationship.id}\" has created!"
end

1.times do
    require 'csv'
    csv = CSV.read('db/seeds/tags.csv')
    csv.each do |t|
   tag = Tag.create!(
        name: t[1]
        )
        puts "\"#{ tag.name }\" has created!"
    end
end

20.times do
    
    like = PostTagRelation.create(
        post_id: rand(1..30),
        tag_id: rand(1..16)
        )
         puts "\"#{ like.id }\" has created!"
end


20.times do
    
    like = Favorite.create(
        post_id: rand(1..30),
        user_id: rand(1..16)
        )
         puts "\"#{ like.id }\" has created!"
end

1.times do
    require 'csv'
    csv = CSV.read('db/seeds/groups.csv')
    csv.each do |group|
    group = Group.create!(
        name: group[1],
        introduction: '楽しくみんなで話しましょう！',
        owner_id: rand(1..16)
        )
        puts "\"#{ group.name }\" has created!"
    end
end

20.times do
    join = GroupUser.create(
        user_id: rand(1..16),
        group_id: rand(1..10)
        )
     puts "\"#{ join.id }\" has created!"
end

