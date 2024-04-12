class PrototypesController < ApplicationController
  before_action :authenticate_user!, only:[:new, :edit, :destroy]
  before_action :correct_user, only: :edit

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
  if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments
  end
  
  def edit
    @prototype = Prototype.find(params[:id])
end

def update
  @prototype = Prototype.find(params[:id])
  if @prototype.update(prototype_params)
      redirect_to prototype_path
    else
      render :edit
    end
end

def destroy
  @prototype = Prototype.find(params[:id])
  @prototype.destroy
  redirect_to root_path
end

  private
  def prototype_params
  params.require(:prototype).permit(:catch_copy, :title, :concept, :image).merge(user_id: current_user.id)
end

def correct_user
  @prototype = Prototype.find(params[:id])
  unless current_user == @prototype.user
    redirect_to action: :index
    end
  end

end
