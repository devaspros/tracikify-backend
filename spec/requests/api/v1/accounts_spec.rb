require "rails_helper"

describe "Accounts API", type: :request do
  describe "GET /api/v1/accounts" do
    it "returns a list of accounts" do
      user = create(:user)
      account = create(
        :account,
        user: user,
        name: "Main Account",
        balance: 1000
      )
      token = JsonWebToken.encode(payload: { user_id: user.id })
      headers = { "Authorization" => "Token #{token}" }

      get "/api/v1/accounts", headers: headers, as: :json

      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body)
      expect(body).to be_an(Array)
      expect(body.first["name"]).to eq("Main Account")
    end
  end

  describe "GET /api/v1/accounts/:id" do
    context "when the account exists" do
      it "returns the account details" do
        user = create(:user)
        account = create(
          :account,
          user: user,
          name: "Main Account",
          balance: 1000
        )
        token = JsonWebToken.encode(payload: { user_id: user.id })
        headers = { "Authorization" => "Token #{token}" }

        get "/api/v1/accounts/#{account.id}", headers: headers, as: :json

        expect(response).to have_http_status(:ok)

        body = JSON.parse(response.body)
        expect(body["id"]).to eq(account.id)
        expect(body["name"]).to eq("Main Account")
      end
    end

    context "when the account does not exist" do
      it "returns a not found error" do
        user = create(:user)
        token = JsonWebToken.encode(payload: { user_id: user.id })
        headers = { "Authorization" => "Token #{token}" }

        get "/api/v1/accounts/9999", headers: headers, as: :json

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "POST /api/v1/accounts" do
    context "when the request is valid" do
      it "creates a new account" do
        user = create(:user)
        token = JsonWebToken.encode(payload: { user_id: user.id })
        headers = { "Authorization" => "Token #{token}" }

        valid_params = {
          account: {
            name: "New Account",
            balance: 500
          }
        }

        post "/api/v1/accounts", params: valid_params, headers: headers, as: :json

        expect(response).to have_http_status(:created)

        body = JSON.parse(response.body)
        expect(body["name"]).to eq("New Account")
        expect(body["balance"]).to eq(500)
      end
    end

    context "when the request is invalid" do
      it "returns an error" do
        user = create(:user)
        token = JsonWebToken.encode(payload: { user_id: user.id })
        headers = { "Authorization" => "Token #{token}" }

        invalid_params = { account: { name: "" } }

        post "/api/v1/accounts", params: invalid_params, headers: headers, as: :json

        expect(response).to have_http_status(:unprocessable_entity)

        body = JSON.parse(response.body)
        expect(body["errors"]).to include("Name can't be blank")
      end
    end
  end

  describe "PUT /api/v1/accounts/:id" do
    context "when the account exists" do
      it "updates the account" do
        user = create(:user)
        account = create(
          :account,
          user: user,
          name: "Main Account",
          balance: 1000
        )
        token = JsonWebToken.encode(payload: { user_id: user.id })
        headers = { "Authorization" => "Token #{token}" }

        update_params = { account: { name: "Updated Account", balance: 2000 } }

        put "/api/v1/accounts/#{account.id}", params: update_params, headers: headers, as: :json

        expect(response).to have_http_status(:ok)

        body = JSON.parse(response.body)
        expect(body["name"]).to eq("Updated Account")
        expect(body["balance"]).to eq(2000)
      end
    end

    context "when the account does not exist" do
      it "returns a not found error" do
        user = create(:user)
        token = JsonWebToken.encode(payload: { user_id: user.id })
        headers = { "Authorization" => "Token #{token}" }

        update_params = { account: { name: "Updated Account", balance: 2000 } }

        put "/api/v1/accounts/9999", params: update_params, headers: headers, as: :json

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "DELETE /api/v1/accounts/:id" do
    context "when the account exists" do
      it "deletes the account" do
        user = create(:user)
        account = create(
          :account,
          user: user,
          name: "Main Account",
          balance: 1000
        )
        token = JsonWebToken.encode(payload: { user_id: user.id })
        headers = { "Authorization" => "Token #{token}" }

        delete "/api/v1/accounts/#{account.id}", headers: headers, as: :json

        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
