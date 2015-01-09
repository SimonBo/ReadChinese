class FavoriteWordsController < ApplicationController
  before_action :set_favorite_word, only: [:show, :edit, :update, :destroy]

  # GET /favorite_words
  # GET /favorite_words.json
  def index
    @favorite_words = FavoriteWord.all
  end

  # GET /favorite_words/1
  # GET /favorite_words/1.json
  def show
  end

  # GET /favorite_words/new
  def new
    @favorite_word = FavoriteWord.new
  end

  # GET /favorite_words/1/edit
  def edit
  end

  # POST /favorite_words
  # POST /favorite_words.json
  def create
    @favorite_word = FavoriteWord.new(favorite_word_params)

    respond_to do |format|
      if @favorite_word.save
        format.html { redirect_to @favorite_word, notice: 'Favorite word was successfully created.' }
        format.json { render :show, status: :created, location: @favorite_word }
      else
        format.html { render :new }
        format.json { render json: @favorite_word.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /favorite_words/1
  # PATCH/PUT /favorite_words/1.json
  def update
    respond_to do |format|
      if @favorite_word.update(favorite_word_params)
        format.html { redirect_to @favorite_word, notice: 'Favorite word was successfully updated.' }
        format.json { render :show, status: :ok, location: @favorite_word }
      else
        format.html { render :edit }
        format.json { render json: @favorite_word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /favorite_words/1
  # DELETE /favorite_words/1.json
  def destroy
    @favorite_word.destroy
    respond_to do |format|
      format.html { redirect_to favorite_words_url, notice: 'Favorite word was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_favorite_word
      @favorite_word = FavoriteWord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def favorite_word_params
      params.require(:favorite_word).permit(:user_id, :word_id)
    end
end
