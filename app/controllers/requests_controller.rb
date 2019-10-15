class RequestsController < ApplicationController
    def create
        if(params[:receiver_id] && params[:receiver_id] != current_user.id)
            not_request = Request.where("((sender_id = #{current_user.id} AND receiver_id = #{params[:receiver_id]}) OR (sender_id = #{params[:receiver_id]} AND receiver_id = #{current_user.id})) AND (is_accepted != false OR is_accepted is null)").count == 0
            if not_request
                request = Request.new(:receiver_id => params[:receiver_id],:sender_id => current_user.id, :is_accepted => nil)
                if request.save
                    render json:{ status: 200 }
                else
                    render json:{ errors: "Can't save it!", status: 500 }
                end
            else
                render json:{ errors: "The request is already there!", status: 406}
            end
            
        else
            render json:{ errors: "Receiver's id is not correct!", status: 403 }
        end
    end
    
    def update
        if params[:id]
            # byebug
            # requests = Request.where("sender_id = #{params[:sender_id]} AND receiver_id = #{current_user.id} AND is_accepted is null")
            # requests.each do |request|
            #     request.update(:is_accepted => params[:is_accepted])
            # end
            request = Request.find(params[:id])
            if request.update(:is_accepted => params[:is_accepted])
                if params[:is_accepted]
                    chanel = Chanel.create(:is_group => false)
                    chanel_user_sender = ChanelUser.create(:chanel_id => chanel.id, :user_id => current_user.id)
                    chanel_user_receiver = ChanelUser.create(:chanel_id => chanel.id, :user_id => params[:sender_id])
                end
                render json:{ status: 200 }
            else
                render json:{ errors: "Can't update!", status: 500 }
            end
            
        else
            render json:{ errors: "Request id is not correct!", status: 403 }
        end
    end
    
end
