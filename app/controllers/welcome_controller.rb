class WelcomeController < ApplicationController
  def index
  end

  def home
  end

  def about
  end

  def contact_us
    
  end
  
  def thank_you
  end


  def bill_splitter
     if params 
 @pay = (params[:amount].to_f*(params[:tax].to_f/100)  + params[:amount].to_f + params[:tip].to_f)/params[:people].to_f 
     end
    end
    

  
end
