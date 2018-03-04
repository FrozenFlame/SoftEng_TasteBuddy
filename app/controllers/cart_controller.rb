class CartController < ApplicationController
    def show
        @cart = User.find_by(userid: session[:user_id]).cart
        puts "[cart_controller] cartcontents: " +@cart.to_s
    end
    def addToCart
        prodcode = params[:prodCode]
        qty = params[:qty]

        if qty != nil && qty.to_i > 0
            ar = [prodcode, qty.to_i]
            @usercart = User.find_by(userid: session[:user_id])
            puts "[cart_controller] user cart 1 %s " % @usercart.cart.to_s
            # @usercart.add_to_set(cart: [ar])
            @usercart.cart.push(ar)
            @usercart.save
            puts "[cart_controller] user cart 2 %s " % @usercart.cart.to_s
            puts "[cart_controller] <%s> prod" % prodcode
            puts "[cart_controller] at least you made it. %d " % qty.to_s
            puts "[cart_controller] added to your cart: %s " % ar.to_s
            redirect_back(fallback_location: :back)
        else
            puts "[cart_controller] illegal amount "
            redirect_back(fallback_location: :back)
        end

    end

    def addToCart_dupe #dupe
        prodcode = params[:prodCode]
        qty = params[:qty].to_i
        ar = [prodcode, qty]
        @usercart = User.find_by(userid: session[:user_id])
        puts "[cart_controller] user cart 1 %s " % @usercart.cart.to_s
        @usercart.add_to_set(cart: [ar])
        puts "[cart_controller] user cart 2 %s " % @usercart.cart.to_s
        puts "[cart_controller] <%s> prod" % prodcode
        puts "[cart_controller] at least you made it. %d " % qty.to_s
        puts "[cart_controller] added to your cart: %s " % ar.to_s

        redirect_back(fallback_location: :back)
    end
    # x.delete_at(x.index 2)

    def removeFromCartIndex
        @user = User.find_by(userid: session[:user_id])
        redirect_back(fallback_location: :back)
    end

    def total_price(oC)
        # @pc = Pricecalc.new(oC)
        return Ordrcontentgetter.total_price(oC)
    end
    helper_method :total_price

    private
        def empty_cart(user)
            user.cart = []
            # user.save
        end

        def add_cart(user, added) # for singular
            user.cart = [added]
            # user.save
        end
        
        def fill_cart(user, newcart) # for multiple
            user.cart = newcart
            user.save
        end
end