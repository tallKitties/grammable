class GramsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_gram, only: [:show, :edit, :update, :destroy]

  def index
    @grams = Gram.all
  end

  def show
    render_error unless @gram
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
    return render_error unless @gram
    return render_error(:forbidden) if @gram.user != current_user
  end

  def update
    return render_error unless @gram
    if @gram.user != current_user
      return render_error(:forbidden) if @gram.user != current_user
    end

    @gram.update_attributes(gram_params)
    if @gram.valid?
      redirect_to root_path
    else
      return render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    return render_error unless @gram
    return render_error(:forbidden) if @gram.user != current_user
    @gram.destroy
    redirect_to root_path
  end

  private

  def gram_params
    params.require(:gram).permit(:message, :picture)
  end

  def set_gram
    @gram = Gram.find_by_id(params[:id])
  end
end
