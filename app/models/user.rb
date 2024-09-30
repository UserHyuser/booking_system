# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  password_digest :string
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_username  (username) UNIQUE
#
class User < ApplicationRecord
  has_secure_password

  has_many :appointments, dependent: :destroy

  validates :username, presence: true
  normalizes :username, with: ->(username) { username.downcase }

  # TODO: Password reset
  # generates_token_for(:password_reset, expires_in: 10.minutes) { password_salt }
end
