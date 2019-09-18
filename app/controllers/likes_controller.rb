class LikesController < ApplicationController

    before_action :authenticate_user!

    def create
      
        review = Review.find(params[:review_id])

        like = Like.new(user: current_user, review: review)

        if !can? :like, review

            redirect_to like.review.product, alert: "Can't like review"

        elsif like.save

            flash[:success] = "review liked"
            redirect_to product_path(like.review.product)
        else
            flash[:danger] = like.errors.full_messages.join(", ")
            redirect_to product_path(like.review.product)
        end
    end

    def destroy

        like = current_user.likes.find(params[:id])
        like.destroy
        redirect_to product_path(like.review.product)

    end
end
