class CheckedWordsController < ApplicationController
  before_action :set_checked_word, only: [:show, :edit, :update, :destroy]

  # GET /checked_words
  # GET /checked_words.json
  def index
    @user = User.find(current_user)
    @checked_words = @user.checked_words.order(counter: :desc)
  end

  # GET /checked_words/1
  # GET /checked_words/1.json
  def show
  end

  # GET /checked_words/new
  def new
    @checked_word = CheckedWord.new
  end

  # GET /checked_words/1/edit
  def edit
  end

  # POST /checked_words
  # POST /checked_words.json
  def create
    @checked_word = CheckedWord.new(checked_word_params)

    respond_to do |format|
      if @checked_word.save
        format.html { redirect_to @checked_word, notice: 'Checked word was successfully created.' }
        format.json { render :show, status: :created, location: @checked_word }
      else
        format.html { render :new }
        format.json { render json: @checked_word.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /checked_words/1
  # PATCH/PUT /checked_words/1.json
  def update
    respond_to do |format|
      if @checked_word.update(checked_word_params)
        format.html { redirect_to @checked_word, notice: 'Checked word was successfully updated.' }
        format.json { render :show, status: :ok, location: @checked_word }
      else
        format.html { render :edit }
        format.json { render json: @checked_word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /checked_words/1
  # DELETE /checked_words/1.json
  def destroy
    @checked_word.destroy
    respond_to do |format|
      format.html { redirect_to checked_words_url, notice: 'Checked word was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def mark_as_checked
    if current_user
      checked_word = Word.find(params[:checked_word])
      checked_word.mark_as_checked(current_user)
    end
    render nothing: true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_checked_word
      @checked_word = CheckedWord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def checked_word_params
      params.require(:checked_word).permit(:user_id, :word_id, :counter)
    end
  end
