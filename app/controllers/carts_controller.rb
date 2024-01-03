class CartsController < ApplicationController
  include CustomSessionBehavior

  before_action :require_signin

  def show
    @render_cart = false
    @cart = Cart.find(params[:id])
  end
  
  def add
    session_count_ticker
    @product = Product.find(params[:id])
    user = User.find(session[:user_id])
    user.liked_products << @product.name
    quantity = params[:quantity].to_i
    current_orderable = @cart.orderables.find_by(product_id: @product.id)

    if current_orderable && quantity > 0
      current_orderable.update(quantity: current_orderable.quantity + quantity)
    elsif quantity <= 0
      current_orderable.destroy
    else
      @cart.orderables.create(product: @product, quantity: quantity)
    end

    respond_to do |format|
      format.turbo_stream do 
        # _not_ best  practices (replacing more than one turbo stream here)
        render turbo_stream: [turbo_stream.replace('cart',
                                                    partial: 'carts/cart',
                                                    locals: { cart: @cart }), 
                              turbo_stream.replace(@product)]
      end
    end
  end

  def remove
    session_count_ticker
    Orderable.find(params[:id]).destroy

    respond_to do |format|
      format.turbo_stream do 
        render turbo_stream: turbo_stream.replace('cart',
                                                    partial: 'carts/cart',
                                                    locals: { cart: @cart })
      end
    end
  end
end