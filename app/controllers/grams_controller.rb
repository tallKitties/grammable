class GramsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_gram, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
    render_not_found unless @gram
    end

  def new
    @gram = Gram.new
  end

  def create
    @gram = current_user.grams.new(gram_params)
    if @gram.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    render_not_found unless @gram
  end

  def update
    return render_not_found unless @gram
    @gram.update_attributes(gram_params)
    if @gram.valid?
      redirect_to root_path
    else
      return render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    return render_not_found unless @gram
    @gram.destroy
    redirect_to root_path
  end

  private

  def gram_params
    params.require(:gram).permit(:message)
  end

  def set_gram
    @gram = Gram.find_by_id(params[:id])
  end

  def render_not_found
    render plain: 'Not Found', status: :not_found
  end
end
