class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :move_to_index, only: [:edit]
  def index
    @items = Item.order("created_at DESC")
  end
  
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id]) 
  end

  def update
    @item = Item.find(params[:id])
    if  @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end

  end

  def show
    @item = Item.find(params[:id])
  end


private

  def item_params
    params.require(:item).permit(:name,:image,:price,:description,:category_id,:cost_id,:delivery_id,:prefecture_id,:status_id).merge(user_id: current_user.id)
  end

  def move_to_index
    @item = Item.find(params[:id])
    unless user_signed_in? && current_user.id == @item.user_id
      redirect_to action: :index
    end
  end

end
