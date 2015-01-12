class WordsController < ApplicationController
  before_action :set_word, only: [:show, :edit, :update, :destroy, :unfavorite_word, :favorite_word]

  def unfavorite_word
    word_id = params[:id]
    current_user.favorite_words.delete(word_id)
    respond_to do |format|
      if current_user.save
        format.html { redirect_to favorite_words_path, success: 'Unfavorited the word!' }
      else
        format.html { redirect_to favorite_words_path, warning: 'Failed' }
      end
    end
  end

  def favorite_words
    @favorite_words = []
    current_user.favorite_words.each do |id|
      word = Word.find(id)
      @favorite_words << word
    end
    return @favorite_words
  end

  def favorite_word
    @word.favorite(current_user)
    respond_to do |format|
      search_url = session[:previous_url]
      if current_user.save
        format.html { redirect_to search_url, notice: 'Word favorited!' }
      else
        format.html { redirect_to search_url, notice: 'Failed'}
      end
    end
  end
  # GET /words
  # GET /words.json
  def index
    @words = Word.text_search(params[:query])
  end

  # GET /words/1
  # GET /words/1.json
  def show
  end

  # GET /words/new
  def new
    @word = Word.new
  end

  # GET /words/1/edit
  def edit
  end

  # POST /words
  # POST /words.json
  def create
    @word = Word.new(word_params)

    respond_to do |format|
      if @word.save
        format.html { redirect_to @word, notice: 'Word was successfully created.' }
        format.json { render :show, status: :created, location: @word }
      else
        format.html { render :new }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /words/1
  # PATCH/PUT /words/1.json
  def update
    respond_to do |format|
      if @word.update(word_params)
        format.html { redirect_to @word, notice: 'Word was successfully updated.' }
        format.json { render :show, status: :ok, location: @word }
      else
        format.html { render :edit }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /words/1
  # DELETE /words/1.json
  def destroy
    @word.destroy
    respond_to do |format|
      format.html { redirect_to words_url, notice: 'Word was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_word
      @word = Word.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def word_params
      params.require(:word).permit(:traditional_char, :simplified_char, :meaning, :pronunciation)
    end
  end
