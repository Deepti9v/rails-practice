
##########################################################################################
#This file contains commands for model creations and queries
##########################################################################################
rails g model Dojo name:string city:string state:string
rails g model Ninja references dojo:references first_name:string last_name:string

class Dojo < ActiveRecord::Base
  has_many :ninjas, :dependent => :delete_all
  validates :name, :city, presence: true
  validates :state, length: {minimum: 2}
end

class Ninja < ActiveRecord::Base
  belongs_to :dojo
  validates :first_name, :last_name , presence: true

  def name
    "#{self.first_name} #{self.last_name}"
  end
end

Dojo.create(name:"Deepti",city:"LA",state:"CA")
Dojo.create(name:"Dee",city:"Tempe",state:"AZ")
Dojo.create(name:"DeeAgain",city:"Tempe",state:"AZ")
Dojo.find(3).destroy
Dojo.destroy_all

Dojo.create(name:"Ruby",city:"LA",state:"CA")
Dojo.create(name:"Rails",city:"LA",state:"CA")

Ninja.create(dojo:Dojo.find(6),first_name:"Deepti",last_name:"V")
Ninja.create(dojo:Dojo.find(7),first_name:"Mike",last_name:"A")
Ninja.create(dojo:Dojo.find(7),first_name:"Marley",last_name:"B")

Dojo.find(7).ninjas
Dojo.find(7).ninjas.map{|x| x.name}.sort.reverse

##########################################################################################

rails g model blogd name:string description:text
rails g model post blogd:references title:string content:text
rails g model message post:references author:string message:text

class Blogd < ActiveRecord::Base
  has_many :posts
  validates :name, :description , presence: true
end

class Post < ActiveRecord::Base
  belongs_to :blogd
  has_many :messages, dependent: :destroy
  validates :title, presence: true
  validates :content, length: {minimum: 2},  presence: true
end

class Message < ActiveRecord::Base
  validates :author ,  presence: true
  validates :message, length: {minimum: 15}
  belongs_to :post
end

Blogd.create(name:"Ruby",description:"Ruby related")
Blogd.create(name:"Rails",description:"Rails related")
Blogd.create(name:"Java",description:"Java related")
Blogd.create(name:"C++",description:"C++ related")

Post.create(blogd:Blogd.find(6),title:"Ruby IRB issue",content:"Ruby IRB issue")
Post.create(blogd:Blogd.find(6),title:"Ruby model deletion issue",content:"unable to delete model and db table")
Post.create(blogd:Blogd.find(7),title:"Rails model deletion issue",content:"unable to delete model and db table")
Post.create(blogd:Blogd.find(7),title:"Rails Migration help",content:"unable to delete model and db table")

Message.create(post:Post.find(1),author:"Jamie",message:"Are you trying with irb? Try again with rails c")
Message.create(post:Post.find(1),author:"Ricky",message:"I have the same issue")
Message.create(post:Post.find(2),author:"Rita",message:"Do it in model drop command")
Message.create(post:Post.find(2),author:"Rishi",message:"Or delete in DB using rails db command")

#retrieve all posts for the blog ID 5
Blogd.find(5).posts

#retrieve all posts for the last blog (sorted by title in the asc order).
Blogd.last.posts.order('title asc')

#update the first post's title.
Post.first.title = "A new title Ruby reload issue"

#delete the first post (have the model automatically delete all messages associated with the third post when you delete the third post).
Post.first.destroy

#retrieve all blogs.
Blogd.all

#all blogs whose id is less than 5.
Blogd.where("id>?",5)

##########################################################################################
rails generate model Team name:string mascot:string stadium:string
rails generate model Player name:string team:references

class Player < ActiveRecord::Base
  belongs_to :team
end

class Team < ActiveRecord::Base
  has_many :players
end

#Retrieve all players, then write a program that will loop through each player and display their team name, mascot and stadium. How many queries have we done?
players.each do |x|;
puts "#{x.team.name}, #{x.team.mascot}, #{x.team.stadium}"
end

#Retrieve all players and write a program to loop through each player and their team name, mascot and stadium using .includes. How many queries have we done now?
players = Player.includes(:team)
players.each do |x|
puts "#{x.name},#{x.team.name},#{x.team.mascot},#{x.team.stadium}"
end

#Retrieve all players from the 'Chicago Bulls' by using .includes
Team.all.where("name like '%Bulls%'")
Player.includes(:team).where("teams.name = 'Chicago Bulls'").references(":team")

#Retrieve all players along with the team name that play at the 'Staples Center'
Player.joins(:team).select('players.name as Player_Name', 'teams.name as Team_Name', 'teams.stadium as stadium').where("teams.stadium = 'Staples Center'")

#Remember that only joins have select working, does not work on includes cos its an association
#Retrieve all teams that have any player that start their name with the letter 'Z' by using .includes and .joins

Team.joins(:players).select('players.name as player_name','teams.name as team_name').where("players.name like 'Z%'")

teams = Team.includes(:players).where("players.name like 'Z%'").references(:players)
teams.each do |x|
  puts "#{x.players.first.name} #{x.name}"
end

##########################################################################################
rails g model User first_name:string last_name:string email_address:string
rails g model Blogd name:string description:text
rails g model Post user:references  blogd:references title:string content:text
rails g model Owner user:references blogd:references
rails g model Message user:references post:references author:string message:text
rails g model Comment data:String commentable:references{polymorphic}

#User
class User < ActiveRecord::Base
  has_many :messages
  has_many :posts
  has_many :owners

  has_many :blogds , through: :owners
  has_many :blog_posts , through: :posts , source: :blogd

  validates :first_name, :last_name , presence: true
  EMAIL_REGEX = /([a-z0-9])+@([a-z]+)\.([a-z]{1,3})/i

  validates :email_address, format: { with: EMAIL_REGEX}
  has_many :comments , as: :commentable

  def fullname
    "#{first_name} #{last_name}"
  end
end
#Post
class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :blogd
  has_many :messages

  validates :title,:content , presence: true
  has_many :comments , as: :commentable
end
#Owner
class Owner < ActiveRecord::Base
  belongs_to :user
  belongs_to :blogd
end
#Message
class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  validates :author, :message , presence: true
  has_many :comments , as: :commentable
end
#Blogd
class Blogd < ActiveRecord::Base
  has_many :posts
  has_many :owners

  has_many :users , through: :owners
  has_many :created_by_user , through: :posts , source: :user

  validates :name, :description , presence: true
  has_many :comments , as: :commentable
end

User.create(first_name: "Deepti",last_name: "V",email_address: "deepti@gmail.com")
User.create(first_name: "Patrick",last_name: "V",email_address: "deepti@gmail.com")
User.create(first_name: "Roy",last_name: "V",email_address: "deepti@gmail.com")
User.create(first_name: "Mike",last_name: "V",email_address: "deepti@gmail.com")

Blogd.create(name: "Movies", description: "All about movies")
Blogd.create(name: "Board Games", description: "All about Board Games")
Blogd.create(name: "Table Tennis", description: "All about Table Tennis")
Blogd.create(name: "Ruby", description: "All about Ruby")
Blogd.create(name: "Rails", description: "All about ROR")

 #Have the first 3 blogs be owned by the first user
Owner.create(user:User.first, blogd:Blogd.first)
Owner.create(user:User.first, blogd:Blogd.second)
Owner.create(user:User.first, blogd:Blogd.third)

#Have the 4th blog you create be owned by the second user
Owner.create(user:User.second, blogd:Blogd.fourth)

#Have the 5th blog you create be owned by the last user
Owner.create(user:User.last, blogd:Blogd.last)

 #Have the third user own all of the blogs that were created.
Blogd.all.each {|blog| Owner.create(user:User.third,blogd:blog)}

#Have the first user create 3 posts for the blog with an id of 2.
3.times.each{ |x| Post.create(user:User.first, blogd:Blogd.find(2),title:"Title #{x+1}",content:"Content #{x+1}")}

#Have the second user create 5 posts for the last Blog.
5.times.each {|x| Post.create(user:User.second,blogd:Blogd.last,title:"Title #{x+1}",content:"Content #{x+1}")}

#Have the 3rd user create several posts for different blogs.
Post.create(user:User.third,blogd:Blogd.find(1),title:"Title for the first blog",content:"Content for the first blog")
Post.create(user:User.third,blogd:Blogd.find(2),title:"Title for the second blog",content:"Content for the second blog")
Post.create(user:User.third,blogd:Blogd.find(3),title:"Title for the third blog",content:"Content for the third blog")

#Have the 4th user create 3 messages for the last post you created.
Message.create(user:User.find(4),post:Post.last,author:"#{User.find(4).fullname}",message:"Creating the message")
Message.create(user:User.find(4),post:Post.last,author:"#{User.find(4).fullname}",message:"Creating another message")

#Change the owner of the 2nd post to the last user.
Post.second.update(user: User.last)

#Change the 2nd post's content to be something else.
Post.second.update(content: "Hello")

# Retrieve all blogs owned by the 3rd user
User.third.blogds

#Retrieve all posts that were created by the 3rd user
User.third.posts

#Retrieve all messages left by the 4th user
User.fourth.messages

#Retrieve all posts associated with the blog id 5 as well as who left these posts.
Post.joins(:blogd,:user).where("blogds.id=5").select('users.first_name','users.last_name','posts.*')

#Retrieve all messages associated with the blog id 5 along with all the user information of those who left the messages
Message.joins(:post,:user).where(post: Blogd.find(3).posts).select("*")

#Grab all user information of those that own the first blog
Blogd.first.users

#Change it so that the first blog is no longer owned by the first user.
Owner.where("blogd_id=1").update_all("user_id=4")

#Polymorphism
Comment.create(data:"First comment",commentable:Post.first)
Comment.create(data:"First comment",commentable:Blogd.first)
Comment.create(data:"First comment",commentable:Message.first)
Comment.create(data:"First comment",commentable:User.first)

User.first.comments
Blogd.last.comments
Comment.create(data:"Comment for the second User",commentable:User.find(2))
Message.find(7).comments

Location.group("address").having('count(address)>1') #group by with count>1
##########################################################################################
rails g model Person first_name:string last_name:string
rails g model Friendship person_id:integer friend_id:integer
