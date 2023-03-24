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
  
    require 'csv'
    csv = CSV.read('db/seeds/relationships.csv')
    csv.each do |relationship|
    relationship = Relationship.create!(
        followed_id: relationship[0],
        follower_id: relationship[1]
     )
    puts "\"#{relationship.id}\" has created!"
    end

    require 'csv'
    csv = CSV.read('db/seeds/tags.csv')
    csv.each do |t|
   tag = Tag.create!(
        name: t[1]
        )
        puts "\"#{ tag.name }\" has created!"
    end

    require 'csv'
    csv = CSV.read('db/seeds/posttags.csv')
    csv.each do |tag|
    like = PostTagRelation.create(
        post_id: tag[0],
        tag_id:  tag[1]
        )
         puts "\"#{ like.id }\" has created!"
    end



    require 'csv'
    csv = CSV.read('db/seeds/posttags.csv')
    csv.each do |like|
    like = Favorite.create(
        post_id: like[0],
        user_id: like[1]
        )
         puts "\"#{ like.id }\" has created!"
    end


    require 'csv'
    csv = CSV.read('db/seeds/groups.csv')
    csv.each do |group|
    group = Group.create!(
        name: group[1],
        introduction: '楽しくみんなで話しましょう！',
        owner_id: group[0]
        )
        puts "\"#{ group.name }\" has created!"
    end

    require 'csv'
    csv = CSV.read('db/seeds/join.csv')
    csv.each do |join|
    join = GroupUser.create(
        user_id: join[0],
        group_id: join[1]
        )
      puts "\"#{ join.id }\" has created!"
    end