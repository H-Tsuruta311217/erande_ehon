# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
  email: 'testc@testc.com',
  password: '111111'
)

category_names = ["0歳","1歳","2歳","3歳","4歳","5歳","6歳","どうわ","どうぶつ","のりもの","むし"]
category_names.each do |name|
  Category.create!(name: name)
end