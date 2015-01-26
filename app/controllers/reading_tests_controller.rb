class ReadingTestsController < ApplicationController
  before_action :set_reading_test, only: [:show, :edit, :update, :destroy]

  # GET /reading_tests
  # GET /reading_tests.json
  def index
    @reading_tests = ReadingTest.where("user_id = ?", current_user.id)
  end

  # GET /reading_tests/1
  # GET /reading_tests/1.json
  def show
  end

  # GET /reading_tests/new
  def new
    @reading_test = ReadingTest.new
  end

  # GET /reading_tests/1/edit
  def edit
  end

  # POST /reading_tests
  # POST /reading_tests.json
  def create
    @reading_test = ReadingTest.new(reading_test_params)

    test_type = params[:reading_test][:test_type]
    if test_type == 'gap-fill'
      @reading_test.prepare_gap_fill_test
    end
    
    respond_to do |format|
      if @reading_test.save
        format.html { redirect_to @reading_test, notice: 'Reading test was successfully created.' }
        format.json { render :show, status: :created, location: @reading_test }
      else
        format.html { render :new }
        format.json { render json: @reading_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reading_tests/1
  # PATCH/PUT /reading_tests/1.json
  def update
    respond_to do |format|
      if @reading_test.update(reading_test_params)
        format.html { redirect_to @reading_test, notice: 'Reading test was successfully updated.' }
        format.json { render :show, status: :ok, location: @reading_test }
      else
        format.html { render :edit }
        format.json { render json: @reading_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reading_tests/1
  # DELETE /reading_tests/1.json
  def destroy
    @reading_test.destroy
    respond_to do |format|
      format.html { redirect_to reading_tests_url, notice: 'Reading test was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reading_test
      @reading_test = ReadingTest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reading_test_params
      params.require(:reading_test).permit(:user_id, :text_id, :data, :test_type)
    end
end
