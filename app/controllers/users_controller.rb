class UsersController < ApplicationController
    def new # this is the creation of a new user.
        @user = User.new
        if User.last() == nil
            puts "[user_controller] db.users empty, first code generated"
            @genCode = 'U00001'
        else
            @prevID = User.last().userid[1..5].to_i
            @prevID = @prevID +1
            @genCode = "U" +@prevID.to_s.rjust(5, "0")
        end
    end

    def create
        nigga = []
        @user = User.new(user_params)
        
        if @user.save # user completes signup
            redirect_to root_url, notice: "Signup complete"
        else # user cancelled their signup, re-render previous
            render "new"
        end

    end

    private
        def user_params
            params.require(:user).permit(:userid, :username, :password)
        end

end