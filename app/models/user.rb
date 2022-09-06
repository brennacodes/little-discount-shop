class User < ApplicationRecord
  validates :username, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password

  has_secure_password

  enum role: %w(default manager admin)

  def self.from_google_auth(response)
    find_or_create_by(uid: response[:uid]) do |user|
      user.username = response[:info][:name]
      user.email = response[:info][:email]
      user.password = SecureRandom.hex(15)
      user.token = response[:extra][:id_token]
    end
  end
end