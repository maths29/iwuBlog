require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET #index' do
  before { get '/users' } # Updated to use the path string directly

    it 'returns a 200 OK status' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'includes the correct placeholder text in the response body' do
      expect(response.body).to include('Here is a list of users')
    end
  end

  describe 'GET #show' do
  before { get '/users/1' } # Updated to use the path string directly

    it 'returns a 200 OK status' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end

    it 'includes the correct placeholder text in the response body' do
      expect(response.body).to include('Here is the details of user')
    end
  end
end