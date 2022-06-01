class ArticlesController < ApplicationController

    #執行操作前，先到set
    before_action :set_article, only:[:show, :edit, :update, :destroy]
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update, :destroy]


    def show
        # redirect_to article_path(@article)
    end
    def index
        @articles = Article.paginate(page: params[:page], per_page: 5)
    end
    def new
        @article = Article.new
    end

    def edit
       # redirect_to article_path(@article)
    end
    def create
        #rander plain: params[:article]
        @article = Article.new(article_params)  #params.require(:article).permit(:title,:description) =>參數

        @article.user = current_user

        #render plain: @article.inspect
        if @article.save
            flash[:notice] = "Article was creared successfully!"
            # redirect_to article_path(@article)
            redirect_to @article
        else
            render 'new' #重新填表單
        end
    end

    def update
       #@article = Article.find(params[:id])
       if @article.update(article_params) #params.require(:article).permit(:title,:description) =>參數
        flash[:notice] = "Article was updated successfully."
        redirect_to @article 
       else
        render 'edit'
       end
    end

    def destroy
        #@article = Article.find(params[:id])
        @article.destroy
        redirect_to articles_path
    end

    private
    
    def set_article
        @article = Article.find(params[:id])
    end 

    def article_params
        params.require(:article).permit(:title,:description)
    end

    def require_same_user
        if current_user != @article.user
            flash[:alert] = "You can only edit or delete your own article"
            redirect_to @article
        end
    end
end
