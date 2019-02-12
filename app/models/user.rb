# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  provider               :string
#  uid                    :string
#  image                  :string
#  website                :string
#  biography              :text
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable,
         omniauth_providers: [:twitter]

  validates :name, presence: true, length: { in: 6..50 }

  has_many :posts, dependent: :destroy
  has_many :likes
  has_many :comments
  has_many :bookmarks

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.image = auth.info.image
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
