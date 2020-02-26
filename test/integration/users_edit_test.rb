# frozen_string_literal: true

require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test 'unsuccessful edit' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: '1234',
                                              email: 'foo@invalid',
                                              password: 'foo',
                                              password_confirmation: 'bar' } }

    assert_template 'users/edit'
    assert_select 'li', { count: 8 }
  end

  test 'successful edit' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user:
                                        { name: '1234asdf',
                                          email: 'foo@invalid.com',
                                          password: 'barvalid',
                                          password_confirmation: 'barvalid' } }

    assert_redirected_to user_path(@user)
    assert_select 'div.alert', { count: 0 }
  end

  test 'successful edit 2' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = 'Foo Bar'
    email = 'foo@bar.com'
    patch user_path(@user), params: { user: { name: name,
                                              email: email,
                                              password: '',
                                              password_confirmation: '' } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end
