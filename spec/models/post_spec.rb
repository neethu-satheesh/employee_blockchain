require 'spec_helper'

describe Post do
  context 'create' do
    let(:title) { 'Post' }
    let(:url) { 'https://www.google.com/' }
    let!(:user) { FactoryGirl.create(:user) }
    let!(:post) { FactoryGirl.create(:post, title: title, url: url, user: user) }

    it 'has successfully created a post' do
      expect(post.title).to eq(title)
      expect(post.url).to eq(url)
      expect(post.user.id).to eq(user.id)
    end
  end
end
