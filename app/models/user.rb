# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: :friend

  include Gravtastic
  gravtastic
  is_gravtastic

  def friends
    friendships.map { |friendship| friendship.friend if friendship.accepted }
  end

  # Users who have yet to confirme friend requests
  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.accepted }.compact
  end

  # Users who have requested to be friends
  def friend_requests
    inverse_friendships.map { |friendship| friendship.user unless friendship.accepted }.compact
  end

  def friend?(user)
    friends.include?(user)
  end

  def find_friendship(friend)
    Friendship.where('user_id = ? and friend_id = ?', id, friend.id).take
  end
end
