class Merchant::OrdersController < Merchant::BaseController


  def show
    @order = Order.find(params[:order_id])
  end

  def update
    item = Item.find(params[:item_id])
    order = Order.find(params[:order_id])
    item_order = ItemOrder.where(item_id:params[:item_id], order_id:params[:order_id])
    item_order[0].update_attribute(:status, "Fulfilled")
    item_order[0].save
    amount = item.inventory - order.amount_wanted(params[:item_id])
    item.update_attribute(:inventory, amount)
    if item.save
      flash[:notice] = "#{item.name} inventory has been subtract to fulfil the order."
      redirect_to "/merchant/#{order.id}"
    end
  end
end
