# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FriendshipsController, type: :controller do
  context 'friendship controller' do
    John = User.create(username: 'John',
                       email: 'john1@example.com',
                       password: 'password')
    Matt = User.create(username: 'Matt',
                       email: 'matt1@example.com',
                       password: 'password')

    let(:friendship){Friendship.create(user_id: Matt.id, friend_id: John.id)}

    it 'creates a friendship' do
      expect{friendship}.to change{Friendship.count}.by(1)
    end

    it 'deletes a friendship' do
      friendship.delete
      expect(Friendship.count).to eq(0)
    end
  end
end
