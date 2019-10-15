class RequestsController < ApplicationController
    def create
        if(params[:receiver_id] && params[:receiver_id] != current_user.id)
            request = Request.new(:receiver_id => params[:receiver_id],:sender_id => current_user.id, :is_accepted => nil)
            # byebug
            if request.save
                render json:{ status: 200 }
            else
                render json:{ errors: "Can't save it!", status: 500 }
            end
        else
            render json:{ errors: "Receiver's id is not correct!", status: 403 }
        end
    end
    
    def update
        
    end
    
end
