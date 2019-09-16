class NewsArticlesController < ApplicationController

    before_action :find_news_article, only: [:edit, :update]

    def new
        @news_article = NewsArticle.new
    end

    def create

        @news_article = NewsArticle.new news_article_params
        if @news_article.save
            redirect_to @news_article
            else
                render :new 
        end
    end

    def show
        @news_article = NewsArticle.find(params[:id])
    end

    def destroy
        @news_article = NewsArticle.find(params[:id])
        @news_article.destroy
        flash[:danger] = "News article was deleted"
        redirect_to news_articles_url
    end

    def index
        @news_articles = NewsArticle.order(created_at: :desc)
    end

    def edit

    end

    def update
       if @news_article.update news_article_params
        
        redirect_to @news_article
       else
        
        render :edit

       end
    end

    private

    def news_article_params
        params.require(:news_article).permit(:title, :description)
    end
    
    def find_news_article
        @news_article = NewsArticle.find(params[:id]) 
    end
end
