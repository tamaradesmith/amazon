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
      ProductMailer.new_product(@product).deliver_now
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
    if params[:tag]
      @tag = Tag.find_or_initialize_by(name: params[:tag])
      @products = @tag.products.order(created_at: :desc)
    else

      @products = Product.order(created_at: :desc)
    end
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
   
    params.require(:product).permit(:title, :price, :description, :tag_names)
  end

  def find_product
    @product = Product.find(params[:id])
  end

  def authorize!
    redirect_to product_path(@product), alert: 'Not autherization' unless can?(:crud, @product)
  end
  
end
