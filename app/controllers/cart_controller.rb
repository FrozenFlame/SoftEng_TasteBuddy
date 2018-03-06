class CartController < ApplicationController
    def show
        @counter = 0 # starting counter num
        @order = Order.new
        if session[:user_id] != nil
            @cart = User.find_by(userid: session[:user_id]).cart
            puts "[cart_controller] cartcontents: " +@cart.to_s
        elsif
            redirect_to root_url
        end
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

    def save_cart
        puts "[cart_controller] params[:qty] is: %d " % params[:qty]
        puts "[cart_controller] params[:indx] is: %d " % params[:indx]
        y = params[:indx].to_i - 1
        qty = params[:qty]
        @user = User.find_by(userid: session[:user_id])
        puts "[cart_controller] before: %s " % @user.cart.to_s
        @user.cart[y][1] = qty.to_i
        puts "[cart_controller] after: %s " % @user.cart.to_s
        @user.save

        redirect_back(fallback_location: :back) # returns you to the cart page
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

    def rmv_cart_atindex
        puts "[cart_controller] deleting a cart entry %s" % params[:index].to_s
        @user = User.find_by(userid: session[:user_id])
        @user.cart.delete_at(params[:index].to_i)
        @user.save
        redirect_back(fallback_location: :back)
    end

    def checkout
        if session[:user_id] != nil
            puts "[cart_controller] checking out."
            @user = User.find_by(userid: session[:user_id])
            
            ## construction of the order
            #orderCode
            genCode = ''
            if Order.last() == nil
                genCode = 'O00001'
            else
                prevOrd = Order.last().orderCode[1..5].to_i
                prevOrd = prevOrd +1
                genCode = 'O' +prevOrd.to_s.rjust(5, "0")
            end
            #orderDate /dateStr
            date ||= Date.today
            #orderUser
                #take from @user.userid
            #~user~ cart extraction and setting of order to user
            @user.add_to_set(orders:genCode)
            newOrderContent = @user.cart
            empty_cart(@user)
            #orderNames
                # done by get_names()
            # @order = Order.new(order_params(genCode, ))
            @order = Order.new(:orderCode => genCode, :orderDate => date, :orderDateStr => date.to_s, :orderUser => @user.userid, :orderNames => get_names(newOrderContent), :orderContents => newOrderContent)
            @order.save


            redirect_to confirm_checkout_path(id:@order._id)
        elsif
            redirect_to root_url
        end
    end

    private
        def empty_cart(user)
            user.cart = []
            user.save
        end

        def add_cart(user, added) # for singular
            user.cart = [added]
            # user.save
        end
        
        def fill_order(order, newcart) # for multiple
            order.orderContent = newcart
            # order.save
        end

        def order_params
            params.require(:order).permit(:orderCode, :orderDate, :orderUser, :orderContent, :orderNames)
        end


        def get_names(oC)
          names = []
          orderContents = oC
          orderContents.each do |item|
              prods = Product.where(:prodCode => item[0])
              prods.each do |p|
                  names.push("[%dx]" % [item[1].to_i] +p.prodName)  
              end
          end
          return names.join(", ")
      end
end