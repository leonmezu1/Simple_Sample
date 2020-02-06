# frozen_string_literal: true

# application main controller-
class ApplicationController < ActionController::Base
  def hello
    render html: 'Hello world'
  end
end
