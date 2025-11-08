class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :posts, dependent: :destroy
  
  # フォロー機能のアソシエーション
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "following_id",
                                   dependent: :destroy
  
  has_many :following, through: :active_relationships, source: :following
  has_many :followers, through: :passive_relationships, source: :follower

  # Validations
  validates :name, presence: true, length: { maximum: 50 }
  validates :introduction, length: { maximum: 200 }, allow_blank: true

  # Methods
  # ユーザーをフォローする
  def follow(other_user)
    following << other_user unless self == other_user
  end

  # ユーザーをアンフォローする
  def unfollow(other_user)
    following.delete(other_user)
  end

  # フォローしているかどうかを確認
  def following?(other_user)
    following.include?(other_user)
  end
end
