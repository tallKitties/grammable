class GramsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
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
    return render_not_found unless @gram
    return render_not_found(:forbidden) if @gram.user != current_user
  end

  def update
    return render_not_found unless @gram
    if @gram.user != current_user
      return render_not_found(:forbidden) if @gram.user != current_user
    end

    @gram.update_attributes(gram_params)
    if @gram.valid?
      redirect_to root_path
    else
      return render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    return render_not_found unless @gram
    return render_not_found(:forbidden) if @gram.user != current_user
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

  def render_not_found(status=:not_found)
    render plain: "#{status.to_s.titleize}", status: status
  end
end
