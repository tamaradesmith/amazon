class ReviewsController < ApplicationController
  before_action :authenticate_user!

  before_action :find_product, only: [:create, :destroy]


  def create
    
    @review = Review.new review_params
    @review.user = current_user
    @review.product = @product
    
   
    if @review.save

      ReviewsMailer.new_review(@review).deliver_now

      redirect_to product_path(@product),
      notice: "review Added"

    else
      @reviews = @product.reviews.order(created_at: :asc)  
      render 'products/show'
      
    end
    
  end

  def destroy
    @product = Product.find params[:product_id]
    @review = Review.find params[:id]
    # @review.user = current_user
    if can? :crud, @review
      @review.destroy
      redirect_to product_path(@product),
      notice: "review deleted"
    else
      redirect_to product_path(@product)
  
        #  head :unauthorized
    end
  end
  
  private
  def review_params
    params.require(:review).permit(:body, :rating, :user)
    
  end

   def find_product
       @product = Product.find(params[:product_id])
    end

   
end
