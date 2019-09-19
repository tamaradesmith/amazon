class TagsController < ApplicationController


  def index

    @tags = Tag.order(created_at: :desc)
    
  end



end
