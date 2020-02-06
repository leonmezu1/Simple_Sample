# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  context 'GET #home' do
    it 'returns a succes response' do
      get static_pages_home_url
      expect(assert_response).to be_succes # response.success?
    end
  end
end
