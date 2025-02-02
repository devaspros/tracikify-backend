require "rails_helper"

describe "Transactions API", type: :request do
  describe "GET /api/v1/accounts/:account_id/transactions" do
    it "returns a list of transactions" do
      user = create(:user)
      account = create(:account, user: user)
      create_list(:transaction, 3, account: account)
      token = JsonWebToken.encode(payload: { user_id: user.id })
      headers = { "Authorization" => "Token #{token}" }

      get "/api/v1/accounts/#{account.id}/transactions", headers: headers, as: :json

      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body)
      expect(body).to be_an(Array)
      expect(body.size).to eq(3)
    end
  end

  describe "GET /api/v1/accounts/:account_id/transactions/:id" do
    it "returns the transaction details" do
      user = create(:user)
      account = create(:account, user: user)
      transaction = create(:transaction, account: account)
      token = JsonWebToken.encode(payload: { user_id: user.id })
      headers = { "Authorization" => "Token #{token}" }

      get "/api/v1/accounts/#{account.id}/transactions/#{transaction.id}", headers: headers, as: :json

      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body)
      expect(body["id"]).to eq(transaction.id)
      expect(body["amount"]).to eq(transaction.amount)
    end
  end

  describe "POST /api/v1/accounts/:account_id/transactions" do
    it "creates a new transaction" do
      user = create(:user)
      account = create(:account, user: user)
      token = JsonWebToken.encode(payload: { user_id: user.id })
      headers = { "Authorization" => "Token #{token}" }

      valid_params = { transaction: { transaction_type: 0, amount: 500, description: "Test Transaction" } }

      post "/api/v1/accounts/#{account.id}/transactions", params: valid_params, headers: headers, as: :json

      expect(response).to have_http_status(:created)

      body = JSON.parse(response.body)
      expect(body["amount"]).to eq(500)
      expect(body["description"]).to eq("Test Transaction")
    end
  end

  describe "PUT /api/v1/accounts/:account_id/transactions/:id" do
    it "updates the transaction" do
      user = create(:user)
      account = create(:account, user: user)
      transaction = create(:transaction, account: account, amount: 100)
      token = JsonWebToken.encode(payload: { user_id: user.id })
      headers = { "Authorization" => "Token #{token}" }

      update_params = { transaction: { amount: 200, description: "Updated Transaction" } }

      put "/api/v1/accounts/#{account.id}/transactions/#{transaction.id}", params: update_params, headers: headers, as: :json

      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body)
      expect(body["amount"]).to eq(200)
      expect(body["description"]).to eq("Updated Transaction")
    end
  end

  describe "DELETE /api/v1/accounts/:account_id/transactions/:id" do
    it "deletes the transaction" do
      user = create(:user)
      account = create(:account, user: user)
      transaction = create(:transaction, account: account)
      token = JsonWebToken.encode(payload: { user_id: user.id })
      headers = { "Authorization" => "Token #{token}" }

      delete "/api/v1/accounts/#{account.id}/transactions/#{transaction.id}", headers: headers, as: :json

      expect(response).to have_http_status(:no_content)
    end
  end
end
