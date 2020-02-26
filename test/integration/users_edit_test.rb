# frozen_string_literal: true

require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test 'unsuccessful edit' do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: '1234',
                                              email: 'foo@invalid',
                                              password: 'foo',
                                              password_confirmation: 'bar' } }

    assert_template 'users/edit'
    assert_select 'div', attributes: { class: 'alert' }
  end

  test 'successful edit' do
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
end
