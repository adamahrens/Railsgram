FactoryBot.define do
  factory :user, class: 'User' do
    name { 'Leroy Jenkins' }
    password { 'password123' }
    password_confirmation { 'password123' }
    sequence(:email) { |n| "email#{n}@email.com" }
    website { 'www.leroyjenkins.com' }
    biography { 'My name is Leroy Jenkins' }
  end

  factory :other, class: 'User' do
    name { 'Walter Sobchak' }
    password { 'password1234' }
    password_confirmation { 'password1234' }
    sequence(:email) { |n| "email#{n}@email.com" }
    website { 'www.waltersobchak.com' }
    biography { 'My name is Walter Sobchak' }
  end

  factory :post, class: 'Post' do
    content { 'Im the first post associated to the first user' }
  end

  factory :second, class: 'Post' do
    content { 'Im the second post associated to the second user' }
  end
end
