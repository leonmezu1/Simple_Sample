# frozen_string_literal: true

require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'get user path and post to user' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: {
        user: { name: '',
                email: 'len@foo',
                password: '12345',
                password_confirmation: '1235' }
      }
    end
    assert_template 'shared/_errors', 'users/new'
  end
end
