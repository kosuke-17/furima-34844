class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :move_to_root_path, only: [:index]
  before_action :move_to_index_from_purchase, only: [:index]

  def index
    @purchase_destination = PurchaseDestination.new
    @item = Item.find(params[:item_id])
  end

  def create
    @purchase_destination = PurchaseDestination.new(purchase_params)
    @item = Item.find(params[:item_id])
    if @purchase_destination.valid?
      pay_item
      @purchase_destination.save
    redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_destination).permit(:post_code, :prefecture_id, :city, :address, :building_name, :phone_number, :purchase_id).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_root_path
    @item = Item.find(params[:item_id])
    if user_signed_in?
      if current_user.id == @item.user_id
        redirect_to root_path
      end
    end
  end

  def move_to_index_from_purchase
    @item = Item.find(params[:item_id])
    if user_signed_in?
      if @item.purchase.present?
        redirect_to root_path
      end
    end
  end
end
