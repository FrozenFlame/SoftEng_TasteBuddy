class CartController < ApplicationController
    def show
        @cart = User.find_by(userid: session[:user_id]).cart
        puts "[cart_controller] cartcontents: " +@cart.to_s
    end
    def addToCart
        prodcode = params[:prodCode]
        qty = params[:qty].to_i
        ar = [prodcode, qty]
        @usercart = User.find_by(userid: session[:user_id])
        puts "[cart_controller] user cart 1 %s " % @usercart.cart.to_s
        @usercart.cart[1] = nil
        @usercart.save
        puts "[cart_controller] user cart 2 %s " % @usercart.cart.to_s
        puts "[cart_controller] <%s> prod" % prodcode
        puts "[cart_controller] at least you made it. %d " % qty.to_s
        puts "[cart_controller] added to your cart: %s " % ar.to_s

        redirect_to root_url
    end

    def removeFromCart

    end

    def total_price(oC)
        # @pc = Pricecalc.new(oC)
        return Ordrcontentgetter.total_price(oC)
    end
    helper_method :total_price
end