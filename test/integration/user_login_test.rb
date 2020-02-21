# frozen_string_literal: true

require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  test 'login tests' do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: '', password: ''} }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert_not flash.empty?
  end
end