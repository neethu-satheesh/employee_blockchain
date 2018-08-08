require 'spec_helper'

describe 'Post Interface' do
  let!(:user) { FactoryGirl.create(:user) }

  def log_in_user(user)
    visit '/users/sign_in'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_on 'Log in'
    expect(page).not_to have_content 'Log in'
    expect(page).to have_content 'Welcome'
  end


  describe 'Post creation ' do
    let(:title) { 'Post' }
    let(:url) { 'https://www.google.com/' }

    before do
      log_in_user(user)
    end

    it 'creates a post' do
      click_on 'Create Post'
      fill_in 'post[title]', with: title
      fill_in 'post[url]', with: url
      click_button 'Submit'
      post = Post.where(title: title, url: url).first
      expect(post).not_to be_nil
      expect(page).to have_content 'Show'
    end

    it 'does not create a post' do
      click_on 'Create Post'
      fill_in 'post[title]', with: ''
      fill_in 'post[url]', with: ''
      click_button 'Submit'
      expect(page).not_to have_content 'Welcome'
    end

    it 'List posts' do
      post = FactoryGirl.create(:post, title: title, url: url, user: user)
      click_on 'List Posts'
      expect(page).to have_content 'Title'
      expect(page).to have_content 'Url'
      expect(page).to have_content title
      expect(page).to have_content url
      expect(page).to have_button 'Show'
      expect(page).to have_button 'Edit'
    end

    it 'Show post' do
      post = FactoryGirl.create(:post, title: title, url: url, user: user)
      click_on 'List Posts'
      click_on 'Show'
      expect(page).to have_content 'Title'
      expect(page).to have_content 'Url'
      expect(page).to have_content title
      expect(page).to have_content url
      expect(page).to have_button 'Edit'
      expect(page).to have_button 'Delete'
      expect(page).to have_button 'Back'
    end

    it 'does not show other users post' do
      new_title = 'Post is good'
      new_url = 'https://www.gmail.com/'
      FactoryGirl.create(:post, title: title, url: url, user: user)
      user1 = FactoryGirl.create(:user, email: 'asdfsdf@fds.com')
      post = FactoryGirl.create(:post, title: new_title, url: new_url, user: user1)
      click_on 'List Posts'
      click_on 'Show'
      expect(page).to have_content 'Title'
      expect(page).to have_content 'Url'
      expect(page).not_to have_content new_title
      expect(page).not_to have_content new_url
      expect(page).to have_button 'Edit'
      expect(page).to have_button 'Delete'
      expect(page).to have_button 'Back'
    end

    it 'Edit post' do
      new_title = 'Post is good'
      new_url = 'https://www.gmail.com/'
      post = FactoryGirl.create(:post, title: title, url: url, user: user)
      click_on 'List Posts'
      click_on 'Show'
      click_on 'Edit'
      expect(page).to have_content 'Title'
      expect(page).to have_content 'Url'
      fill_in 'post[title]', with: new_title
      fill_in 'post[url]', with: new_url
      click_on 'Submit'
      post.reload
      expect(post.title).to eq(new_title)
      expect(post.url).to eq(new_url)
      expect(page).to have_content 'Show Post'
    end
  end
end
