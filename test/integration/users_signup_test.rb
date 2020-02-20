# frozen_string_literal: true

require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'get user path and post to user unsuccesfully' do
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

  test 'get user path and post to user succesfully' do
    get signup_path
    assert_difference 'User.count' do
      post users_path, params: {
        user: { name: 'test1',
                email: 'test@test.com',
                password: '123456',
                password_confirmation: '123456' }
      }
    end
    assert_redirected_to user_path(User.find_by(name: 'test1'))
  end

  test 'sign up triggers error template if present' do
    get signup_path
    post users_path, params: {
      user: { name: 'test',
              email: 'test@test.com',
              password: '123456',
              password_confirmation: '123456' }
    }
    assert_select 'div#error_explanation', { count: 1 }
  end

  test 'sign up triggers error template if name is too short' do
    get signup_path
    post users_path, params: {
      user: { name: 'test',
              email: 'test@test.com',
              password: '123456',
              password_confirmation: '123456' }
    }
    assert_select 'li',
                  { text: 'Name is too short (minimum is 5 characters)' }
  end

  # Keep improving
  test 'sign up triggers error template if name is not present' do
    get signup_path
    post users_path, params: {
      user: { name: '',
              email: '',
              password: '',
              password_confirmation: '' }
    }
    assert_select 'li',
                  { text: "Name can't be blank",
                    count: 1 }
  end
end
