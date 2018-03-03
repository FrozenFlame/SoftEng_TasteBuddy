class MainPageController < ApplicationController
  def index
    # we're gonna need to have some flags here to determine what results will appear.
    @products = Product.all
  end


  def shorten(str)
      if str.length > 50
        return str[0..50] +"..."
      else
        return str  
      end
    end
    helper_method :shorten
end
