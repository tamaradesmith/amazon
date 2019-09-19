class ReviewsMailer < ApplicationMailer
 default from: 'CuteKitten@review.com'
    
 
 def new_review(review)
  
    @review = review
    @product = review.product
    @product_owner = @product.user


    
    mail(
        to: @product_owner.email,
        subject: "#{review.user.first_name} has review your product"
    )

 end

end
