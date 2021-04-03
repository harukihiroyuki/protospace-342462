class PrototypesController < ApplicationController

  before_action :authenticate_user!, except: [:show, :new, :destroy]

 def index
  @prototypes = Prototype.all
 end

 def new
  @prototype = Prototype.new
 end

  def create
    @prototype = Prototype.new(prototype_params)
    #@comment = Comment.create
   if @prototype.save
     redirect_to root_path
   else
     render :new
   end
   end

 def show
  @prototype = Prototype.find(params[:id])
  @comment = Comment.new
  @comments = @prototype.comments.includes(:user)
 end

 def edit
  @prototype = Prototype.find(params[:id])
  unless current_user == @prototype.user
     redirect_to action: :index
  end
 end

 def update
  @prototype = Prototype.find(params[:id])
    @prototype.update(prototype_params)
  if @prototype.update(prototype_params)
    redirect_to root_path
  else
    render :edit
  end
 end

 def destroy
  @prototype = Prototype.find(params[:id])
  #@prototype.destroy
  if @prototype.destroy
    redirect_to root_path
  else
    render :index
  end
 end


  private

  def prototype_params
    params.require(:prototype).permit(:concept,:catch_copy,:title,:image).merge(user_id: current_user.id)
  end
end
