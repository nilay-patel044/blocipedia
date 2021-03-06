class Wiki < ApplicationRecord
  belongs_to :user, optional: true
  has_many :collaborators, dependent: :destroy
  has_many :users, through: :collaborators
end
