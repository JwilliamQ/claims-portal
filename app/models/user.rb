class User < ApplicationRecord
  has_secure_password validations: true
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  has_many :created_claims, class_name: 'Claim', foreign_key: 'claim_username', primary_key: 'name'
end
