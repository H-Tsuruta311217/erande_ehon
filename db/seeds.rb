# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin = Admin.find_or_initialize_by(email: ENV['ADMIN_EMAIL'])
admin.password = ENV['ADMIN_PASSWORD']
admin.save!

5.times do |n|
  member = Member.find_or_initialize_by(email: "test#{n + 1}@test.com")
  member.last_name = "テスト"
  member.first_name = "太郎#{n + 1}"
  member.nickname = "テスト#{n + 1}"
  member.is_active = true
  member.password = '000000'
  member.save
end

category_names = ["0歳","1歳","2歳","3歳","4歳","5歳","6歳","昔ばなし","せいかつ","どうぶつ","のりもの","むし"]
category_names.each do |name|
  Category.find_or_create_by!(name: name)
end