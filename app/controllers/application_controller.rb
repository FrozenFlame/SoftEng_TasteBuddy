class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


   def shorten(str, len)
      if str.length > len
        return str[0..len] +"..."
      else
        return str  
      end
    end
    helper_method :shorten
end
