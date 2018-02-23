require 'rails_helper'

RSpec.describe "Cycles", type: :request do
  describe "GET /cycles" do
    it "works! (now write some real specs)" do
      get cycles_path
      expect(response).to have_http_status(200)
    end
  end
end
