class PurchasesController < ApplicationController
  def create
    params = {
      user: purchase_params[:user],
      cart_id: purchase_params[:cart_id],
      gateway: purchase_params[:gateway],
      address: address_params
    }
    purchase_result = PurchaseService.purchase(params)
      if purchase_result[:completed]
        return render json: { status: :success, order: { id: purchase_result[:order][:id]} }, status: :ok
      else
        return render json: { errors: purchase_result[:errors] }, status: :unprocessable_entity
      end
  end

  private

  def purchase_params
    params.permit(
      :gateway,
      :cart_id,
      user: %i[email first_name last_name],
      address: %i[address_1 address_2 city state country zip]
    )
  end

  def address_params
    purchase_params[:address] || {}
  end
end
