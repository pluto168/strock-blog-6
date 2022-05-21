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

    def edit
        @article = Article.find(params[:id])
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

    def update
       @article = Article.find(params[:id])
       if @article.update(params.require(:article).permit(:title,:description))
        flash[:notice] = "Article was updated successfully."
        redirect_to @article 
       else
        render 'edit'
       end
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to articles_path
    end
end
