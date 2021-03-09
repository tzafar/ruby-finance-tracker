class User < ApplicationRecord
  validates :email, uniqueness: true
  validates :email, presence: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, message: "valid email please"

  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def stock_already_tracked?(ticker)
    stocks.where(ticker: ticker).exists?
  end

  def can_add_stocks
    stocks.count < 10
  end

  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name
    'Anonymose'
  end

  def findFriend(value)
    friends = find_friend_by_field_name("first_name", value) +
      find_friend_by_field_name("last_name", value) +
      find_friend_by_field_name('email', value)
    friends.uniq
  end

  def find_friend_by_field_name(field_name, value)
    User.where("#{field_name} like ?", "%#{value}%")
  end

  def friends?(email)
    friends.where(email: email).exists?
  end

  def unfollow(email)
    friends.where(email: email).first.destroy
  end
end
