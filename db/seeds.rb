# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
ChanelUser.destroy_all
Chanel.destroy_all
Message.destroy_all


PASSWORD = "123"
PIDCTURE_URL = "logo.png"
USER_NAMES = ["Mao Li", "Alice Lee","Kent Cheung","Daseul","Hindreen","Brandon","Logan","John Ivison","John Gootee","Naveed"]

USER_NAMES.each do |name|
    User.create(
        user_name: name,
        email: "#{name}@#{hichat}.com",
        password: PASSWORD,
        picture_url: PIDCTURE_URL,
        description: "I am #{name}!!!!!"
      )
end

