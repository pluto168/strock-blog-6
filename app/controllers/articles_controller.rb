class ArticlesController < ApplicationController
    def show
        @article = Article.find(params[:id])
    end
    def index
        @articles = Article.all
    end
    def new
        @article = Article.new
    end

    def create
        #rander plain: params[:article]
        @article = Article.new(params.require(:article).permit(:title,:description))
        #render plain: @article.inspect
        if @article.save
            flash[:notice] = "Article was creared successfully!"
            #redirect_to article_path(@article)
            redirect_to @article
        else
            render 'new' #重新填表單
        end
    end
end
