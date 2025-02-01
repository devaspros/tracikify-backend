require "rails_helper"

describe "Sessions API", type: :request do
  let!(:user) { create(:user, email: "test@example.com", password: "password123") }

  describe "POST /api/v1/users/sign_in" do
    context "when credentials are valid" do
      it "returns a JWT token and user information" do
        post "/api/v1/users/sign_in", params: {
          email: "test@example.com",
          password: "password123"
        }, as: :json

        expect(response).to have_http_status(:created)

        body = JSON.parse(response.body)

        expect(body["token"]).to be_present
        expect(body["user"]["id"]).to eq(user.id)
        expect(body["user"]["email"]).to eq("test@example.com")
      end
    end

    context "when credentials are invalid" do
      it "returns an error for incorrect password" do
        post "/api/v1/users/sign_in", params: {
          email: "test@example.com",
          password: "wrongpassword"
        }, as: :json

        expect(response).to have_http_status(:unauthorized)

        body = JSON.parse(response.body)
        expect(body["error"]).to eq("Invalid email or password")
      end

      it "returns an error for non-existent email" do
        post "/api/v1/users/sign_in", params: {
          email: "nonexistent@example.com",
          password: "password123"
        }, as: :json

        expect(response).to have_http_status(:unauthorized)

        body = JSON.parse(response.body)
        expect(body["error"]).to eq("Invalid email or password")
      end
    end
  end

  describe "DELETE /api/v1/users/sign_out" do
    context "when logged out successfully" do
      it "returns a success message", :aggregate_failures do
        delete "/api/v1/users/sign_out", headers: {
          "Authorization" => "Bearer #{user.generate_jwt}"
        }, as: :json

        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
