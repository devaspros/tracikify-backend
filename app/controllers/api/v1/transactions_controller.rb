module Api
  module V1
    class TransactionsController < Api::BaseApiController
      before_action :set_transaction, only: [:show, :update, :destroy]

      # GET /api/v1/transactions
      def index
        transactions = current_user.accounts.find(params[:account_id]).transactions

        render json: transactions, status: :ok
      end

      # GET /api/v1/transactions/:id
      def show
        render json: @transaction, status: :ok
      end

      # POST /api/v1/transactions
      def create
        account = current_user.accounts.find(params[:account_id])
        transaction = account.transactions.build(transaction_params)

        if transaction.save
          render json: transaction, status: :created
        else
          render json: { errors: transaction.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PUT/PATCH /api/v1/transactions/:id
      def update
        if @transaction.update(transaction_params)
          render json: @transaction, status: :ok
        else
          render json: { errors: @transaction.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/transactions/:id
      def destroy
        @transaction.destroy

        head :no_content
      end

      private

      def set_transaction
        @transaction = current_user.accounts.find(params[:account_id]).transactions.find(params[:id])
      end

      def transaction_params
        params.require(:transaction).permit(:transaction_type, :amount, :description)
      end
    end
  end
end
