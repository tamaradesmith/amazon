require 'rails_helper'

RSpec.describe NewsArticlesController, type: :controller do

    def current_user
        @current_user ||=FactoryBot.create :user
    end

    describe "#new" do

        context "without signed in user" do

            it "rediects the user to session new" do
                get :new
                expect(response).to redirect_to new_session_path
            end

        end

        context "with signed in user" do

            before do
                current_user = FactoryBot.create :user
                 session[:user_id] = current_user.id
            end
    

            it "render new template" do
           
                get :new

                expect(response).to(render_template(:new))
            end 

            it "Sets an instance variable with a news_article" do
                get :new
                expect(assigns(:news_article)).to(be_a_new(NewsArticle))
            end 

        end
    end

    describe '#create' do      

        def valid_request 
            # byebug
            post :create, params: {news_article: FactoryBot.attributes_for(:news_article)}

        end

        context "without sign in user" do
            
            it "should redirect to sign in page" do
                valid_request
                expect(response).to redirect_to new_session_path
            end
        end

        context "With sign in user" do

            before do
                session[:user_id] = current_user 
            end

            context "with valid parameters" do

                it "saves a new news_article to the db" do

                    count_before = NewsArticle.count
                    valid_request
                    
                    count_after = NewsArticle.count
                    expect(count_after).to eq(count_before + 1)

                end
        
                it "redirect to the show page of that job post" do
                    valid_request
                    news_article = NewsArticle.last
                    expect(response).to(redirect_to(news_article_path(news_article.id)))
                end
            end
       
            context "with invalid parameters" do

                def invalid_request 
                    post :create, params: {news_article: FactoryBot.attributes_for(:news_article, title: nil)}
                end
    
                it "does not create a job post" do
                    count_before = NewsArticle.count
                    invalid_request
                    count_after = NewsArticle.count
                expect(count_after).to eq count_before
                end


                it "re-renders the new template" do
                    invalid_request
                    expect(response).to render_template :new
                end

                it 'assigns an invaild job as an instance variable' do
                    invalid_request
                    expect(assigns(:news_article)).to be_a NewsArticle
                    expect(assigns(:news_article).valid?).to be false
                end
            end
         end 
    end

    describe '#show' do
   

        it "should render show template" do
            news_article = FactoryBot.create(:news_article)
            get(:show, params:{id: news_article.id})
            expect(response).to render_template :show
        end

        it "sets @news_article for the shown object" do
            news_article = FactoryBot.create(:news_article)
            get(:show, params:{id: news_article.id})
            expect(assigns(:news_article)).to eq (news_article)
        end 

    end

    describe '#destroy' do

        it "removes news_article from db"  do
            news_article = FactoryBot.create :news_article
            delete(:destroy, params: {id: news_article.id})
            expect(NewsArticle.find_by(id:news_article.id)).to be(nil)
        end

        it "redirects to news_articles page" do 

            news_article = FactoryBot.create :news_article
            delete(:destroy, params: {id:news_article.id})
            expect(response).to redirect_to news_articles_url
        end

        it 'set a flash message' do
            news_article = FactoryBot.create :news_article
            delete(:destroy, params: {id: news_article.id})
            expect(flash[:danger]).to be
        end

    end

    describe '#index' do
        before do
            get :index
        end

        it "renders index template" do
            expect(response).to render_template :index
        end

        it "assigns an instance vabiable to all created news articles" do
            news_article_1 = FactoryBot.create(:news_article)
            news_article_2 = FactoryBot.create(:news_article)
    
            expect(assigns(:news_articles)).to eq([news_article_2, news_article_1])

        end

    end

    describe '#edit' do

        context "without signed in user" do 

            it 'redirects to the new session page' do
                 news_article = FactoryBot.create(:news_article)
                get(:edit, params: {id: news_article.id})
                expect(response).to redirect_to(new_session_path)
            end

        end


        context "with signed in user" do

            before do
                session[:user_id] = current_user 
            end

            context "With news article owner signed in" do

                it "renders edit templete" do 
                    news_article = FactoryBot.create(:news_article, user: current_user)
                    get(:edit, params: {id: news_article.id})
                    expect(response).to render_template :edit
                end

                it "should get existing news article params" do
                    news_article = FactoryBot.create(:news_article, user: current_user)
                    get(:edit, params: {id: news_article.id})
                    expect(assigns(:news_article)).to eq(news_article)
                end

            end
                context "with non-owner signed in" do

                   it "should redirect the user to the root_page" do
                    news_article = FactoryBot.create(:news_article)
                    get(:edit, params: {id: news_article.id})
                    expect(response).to redirect_to root_path
                   end

                    it "should alerts the user with a flash" do
                        news_article = FactoryBot.create(:news_article)
                        get(:edit, params: {id: news_article.id})
                        expect(flash[:danger]).to be
                    end
                end

        end

    end

    describe "#update" do
        
        before do
            @news_article = FactoryBot.create (:news_article)
        end
     
        context "without sign in user" do

            it "should redirect to signin page" do
                new_title = "#{@news_article.title} New Changes" 
                patch :update, params: {id: @news_article.id, news_article: {title: new_title}}
                 expect(response).to redirect_to(new_session_path)
            end

        end

        context "with sign in user" do
            
            context "non owner of news article" do

                it "should redirect to root_path" do
                     new_title = "#{@news_article.title} New Changes"

                    patch :update, params: {id: @news_article.id, news_article: {title: new_title}}
                    expect(response).to redirect_to root_path
                end
                
                it "should set a flash message"

            end

            context "with valid params" do
            
                context  "ower of news article"

                it "updates changes to news article" do
                new_title = "#{@news_article.title} New Changes"
                patch :update, params: {id: @news_article.id, news_article: {title: new_title}}
                expect(@news_article.reload.title).to eq(new_title)
                end

                it "redirects to news article show templete" do
                    new_title = "#{@news_article.title} New Changes"
                    patch :update, params: {id: @news_article.id, news_article: {title: new_title}}
                    expect(response).to redirect_to @news_article
                end
            end   

            context "with Invalid params" do
                def invalid_request 
                    patch :update, params: {id: @news_article.id, news_article: {title: nil}}
                end
                it "should not update params" do
                    expect{invalid_request}.not_to change {@news_article.reload.title}
                end


                it "renders  the news article edit template" do
                    invalid_request
                    expect(response).to render_template :edit
                end

            end
        end
    end
end
