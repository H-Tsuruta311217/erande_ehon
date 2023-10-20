# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.find_or_create_by!(
  email: 'testc@testc.com',
  password: '111111'
)

5.times do |n|
  Member.find_or_create_by!(
    email: "test#{n + 1}@test.com",
    last_name: "テスト",
    first_name: "太郎#{n + 1}",
    nickname: "テスト",
    is_active: "true",
    password: "000000"
  )
end

category_names = ["0歳","1歳","2歳","3歳","4歳","5歳","6歳","むかしばなし","せいかつ","どうぶつ","のりもの","むし"]
category_names.each do |name|
  Category.find_or_create_by!(name: name)
end