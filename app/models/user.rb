class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :wikis, dependent: :destroy

  before_save { self.email = email.downcase }

  #
  # validates :email, presence: true
  # validates :password, presence: true

  after_initialize { self.role ||= :member}

  enum role: [:member, :admin, :premium]

end
