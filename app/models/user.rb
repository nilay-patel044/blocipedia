class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :wikis, dependent: :destroy
  has_many :collaborators, dependent: :destroy

  before_save { self.email = email.downcase }

  #
  # validates :email, presence: true
  # validates :password, presence: true

  after_initialize { self.role ||= :member}

  enum role: [:member, :admin, :premium]

  def canSee(wiki)
    !wiki.private || wiki.user_id == self.id || self.admin? || self.premium?
  end

end
