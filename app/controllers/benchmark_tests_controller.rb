class BenchmarkTestsController < ApplicationController
  before_action :set_benchmark_test, only: [:show, :edit, :update, :destroy]

  # GET /benchmark_tests
  # GET /benchmark_tests.json
  def index
    @benchmark_tests = BenchmarkTest.order('created_at DESC')
  end

  # GET /benchmark_tests/1
  # GET /benchmark_tests/1.json
  def show
  end

  # GET /benchmark_tests/new
  def new
    @benchmark_test = BenchmarkTest.new
  end

  # GET /benchmark_tests/1/edit
  def edit
  end

  # POST /benchmark_tests
  # POST /benchmark_tests.json
  def create
    @benchmark_test = BenchmarkTest.new(benchmark_test_params)

    respond_to do |format|
      if @benchmark_test.save
        format.html { redirect_to @benchmark_test, notice: 'Benchmark test was successfully created.' }
        format.json { render :show, status: :created, location: @benchmark_test }
      else
        format.html { render :new }
        format.json { render json: @benchmark_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /benchmark_tests/1
  # PATCH/PUT /benchmark_tests/1.json
  def update
    respond_to do |format|
      if @benchmark_test.update(benchmark_test_params)
        format.html { redirect_to @benchmark_test, notice: 'Benchmark test was successfully updated.' }
        format.json { render :show, status: :ok, location: @benchmark_test }
      else
        format.html { render :edit }
        format.json { render json: @benchmark_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /benchmark_tests/1
  # DELETE /benchmark_tests/1.json
  def destroy
    @benchmark_test.destroy
    respond_to do |format|
      format.html { redirect_to benchmark_tests_url, notice: 'Benchmark test was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_benchmark_test
      @benchmark_test = BenchmarkTest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def benchmark_test_params
      params.require(:benchmark_test).permit(:description, :from, :url, :user_cpu_time, :system_cpu_time, :total_cpu_time, :real_cpu_time)
    end
end
