class Claim < ApplicationRecord
  belongs_to :created_by_user, class_name: 'User', foreign_key: 'claim_username', primary_key: 'name'
end
