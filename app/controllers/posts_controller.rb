class PostsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]

    def index
        @posts = Post.all
    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        @post.user_id = current_user.id if current_user

        if @post.save
            flash[:success] = "Just kidding, I'm telling everyone. I'm texting your family right now."
            redirect_to posts_path
        else
            render :new, status: :unprocessable_entity
        end
    end

    private

    def post_params
        params.require(:post).permit(:title, :body, :user_id)
    end
end
