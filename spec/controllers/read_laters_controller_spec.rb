# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReadLatersController, type: :controller do
  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #push' do
    it 'saves URL' do
      expect do
        post :push, params: { read_laters: { url: 'http://example.com/' } }
      end.to change(ReadLater, :count).by(1)
    end

    after { ReadLater.destroy_all }
  end

  describe 'GET #pop' do
    before do
      %w[a b].each { |x| ReadLater.create(url: "http://example.com/#{x}") }
    end

    it 'consume one record' do
      get :pop
      expect(ReadLater.count).to eq 1
    end

    it 'remains "b"' do
      get :pop
      expect(ReadLater.first.url).to include 'b'
    end

    after { ReadLater.destroy_all }
  end

  describe 'POST #bulk_push' do
    let(:urls) do
      <<-EOF.lines.map(&:chomp).map(&:strip).join("\n") # <- this process is as what look text for.
        * [example domain page](https://www.example.com/)
        https://www.artstation.com/
      EOF
    end

    it 'only 1 record inserted' do
      expect do
        post :bulk_push, params: { read_laters: { url: urls } }
      end.to change(ReadLater, :count).by(1)
    end

    after { ReadLater.destroy_all }
  end
end
