# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if User.count.zero?
  admin_user = User.create! email: 'admin@email.com', password: '12345678', confirmed_at: Time.now
  admin_user.add_role :admin
end

if NewsSection.count.zero?
  admin = User.with_role(:admin).first
  %w(행사안내 읽을꺼리 볼꺼리 신간소개 채용공고 업체홍보).each do | section |
    NewsSection.create! title: section, user: admin
  end
end
