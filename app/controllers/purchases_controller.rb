class PurchasesController < ApplicationController
  def create
    if purchase_params[:gateway] == 'paypal'
      render_purchase_result

    elsif purchase_params[:gateway] == 'stripe'
      render_purchase_result
    else
      render json: { errors: [{ message: 'Gateway not supported!' }] }, status: :unprocessable_entity
    end
  end

  private

  def render_purchase_result
    purchase_result = PurchaseService.purchase(purchase_params[:user], purchase_params[:cart_id], address_params)
      if !purchase_result[:completed]
        return render json: { errors: purchase_result[:errors] }, status: :unprocessable_entity
      else
        return render json: { status: :success, order: { id: purchase_result[:order][:id]} }, status: :ok
      end
  end

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
