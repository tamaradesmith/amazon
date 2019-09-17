class NewsArticlesController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :update]
    before_action :find_news_article, only: [:edit, :update, :destroy]

    def new
        @news_article = NewsArticle.new
    end

    def create

        @news_article = NewsArticle.new news_article_params
        @news_article.user = current_user

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
        if !can?(:edit, @news_article)
            flash[:danger] = "Can't delete other users news articles"
            redirect_to root_path

        end
    end

    def update

        if !can?(:update, @news_article)
            redirect_to root_path
        end

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
