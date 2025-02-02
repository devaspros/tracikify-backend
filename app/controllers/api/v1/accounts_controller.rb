module Api
  module V1
    class AccountsController < Api::BaseApiController
      before_action :set_account, only: [:show, :update, :destroy]

      # GET /api/v1/accounts
      def index
        render json: current_user.accounts, status: :ok
      end

      # GET /api/v1/accounts/:id
      def show
        render json: @account, status: :ok
      end

      # POST /api/v1/accounts
      def create
        account = current_user.accounts.build(account_params)

        if account.save
          render json: account, status: :created
        else
          render json: { errors: account.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PUT/PATCH /api/v1/accounts/:id
      def update
        if @account.update(account_params)
          render json: @account, status: :ok
        else
          render json: { errors: @account.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/accounts/:id
      def destroy
        @account.destroy

        head :no_content
      end

      private

      def set_account
        @account = current_user.accounts.find(params[:id])
      end

      def account_params
        params.require(:account).permit(:account_type_id, :name, :balance)
      end
    end
  end
end
