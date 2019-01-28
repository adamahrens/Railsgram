require 'rails_helper'
require 'support/factory_bot'

RSpec.describe 'users can delete posts' do
  context 'when viewing their own post' do
    it 'should be able to delete the post' do
      user = FactoryBot.create(:user)
      post = Post.create(content: 'My first post', user: user)
      expect(user.posts.count).to eq(1)
    end
  end

  context 'when viewing another post' do
    it 'should not be able to delete the post' do
      user = FactoryBot.create(:user)
      other = FactoryBot.create(:other)
      post = Post.create(content: 'My first post', user: user)
      expect(user.posts.count).to eq(1)
    end
  end
end
