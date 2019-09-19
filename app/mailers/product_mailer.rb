class ProductMailer < ApplicationMailer
      default from: 'notifications@amazon.com'

      def new_product(product)

        @product = product
        
        mail(
            to: @product.user.email,
            subject: "#{@product.title} has been created"
        )

      end


end
