require 'rails_helper'
require 'support/factory_bot'

RSpec.describe PostPolicy do
  subject { described_class.new(user, post) }

  context 'being the owner of a post' do
    let(:user) { FactoryBot.create(:user) }
    let(:post) { Post.create(content: 'My first post', user: user) }
    it { is_expected.to permit_action(:destroy) }
  end

  context 'not being the owner of a post' do
    let(:user) { FactoryBot.create(:user) }
    let(:other) { FactoryBot.create(:other) }
    let(:post) { Post.create(content: 'My first post', user: other) }
    it { is_expected.to forbid_action(:destroy) }
  end
end
