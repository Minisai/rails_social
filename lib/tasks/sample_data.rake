namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_microposts
    #make_friendships
  end
end
  def make_users
    AdminUser.create!(:email => 'antonjyha@gmail.com', :password => '5111991', :password_confirmation => '5111991')
    User.create!(:name => "DAS",
                 :email => "d.a.s91@tut.by",
                 :password => "5111991",
                 :password_confirmation => "5111991",
                 :confirmed_at => Time.now)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password,
                   :confirmed_at => Time.now)
    end
  end

  def make_microposts
    User.all(:limit => 6).each do |user|
      50.times do
        user.microposts.create!(:content => Faker::Lorem.sentence(5))
      end
    end
  end

  #def make_friendships
  #  users = User.all
  #  user  = users.first
  #  friends = users[1..50]
  #  inverse_friends = users[3..40]
  #  friends.each { |friend| user.friends.create!(friend) }
  #  inverse_friends.each { |inverse_friend| inverse_friend.friends.create!(user) }
  #end

# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer         default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#  authentication_token   :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  name                   :string(255)
#
