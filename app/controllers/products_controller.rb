class ProductsController < ApplicationController
 before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
 
  before_action :find_product, only: [:show, :edit, :update, :destroy]

  before_action :authorize!, only: [:edit, :update, :destroy]

  def new
    @product = Product.new 
    render :new
  end

  def create
    @product = Product.new product_params
    @product.user = current_user
    if @product.save
      flash[:notice] = "Product created successfully"
        redirect_to product_path(@product)
    else
      render :new
    end
  end

  def show
    @review = Review.new
    @reviews = @product.reviews.order(created_at: :desc)  


  end

  def index 
    @products = Product.all
    
  end

  def edit

  end

  def update
    if @product.update product_params
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

    def destroy
      flash[:notice] = "product deleted"
     @product.destroy
     redirect_to index_products_path
    end


private

  def product_params
    params.require(:product).permit(:title, :price, :description)
  end

  def find_product
    @product = Product.find(params[:id])
  end

  def authorize!
    redirect_to product_path(@product), alert: 'Not autherization' unless can?(:crud, @product)
  end
end
