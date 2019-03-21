require 'test_helper'

class BenchmarkTestsControllerTest < ActionController::TestCase
  setup do
    @benchmark_test = benchmark_tests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:benchmark_tests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create benchmark_test" do
    assert_difference('BenchmarkTest.count') do
      post :create, benchmark_test: { description: @benchmark_test.description, from: @benchmark_test.from, real_cpu_time: @benchmark_test.real_cpu_time, system_cpu_time: @benchmark_test.system_cpu_time, total_cpu_time: @benchmark_test.total_cpu_time, url: @benchmark_test.url, user_cpu_time: @benchmark_test.user_cpu_time }
    end

    assert_redirected_to benchmark_test_path(assigns(:benchmark_test))
  end

  test "should show benchmark_test" do
    get :show, id: @benchmark_test
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @benchmark_test
    assert_response :success
  end

  test "should update benchmark_test" do
    patch :update, id: @benchmark_test, benchmark_test: { description: @benchmark_test.description, from: @benchmark_test.from, real_cpu_time: @benchmark_test.real_cpu_time, system_cpu_time: @benchmark_test.system_cpu_time, total_cpu_time: @benchmark_test.total_cpu_time, url: @benchmark_test.url, user_cpu_time: @benchmark_test.user_cpu_time }
    assert_redirected_to benchmark_test_path(assigns(:benchmark_test))
  end

  test "should destroy benchmark_test" do
    assert_difference('BenchmarkTest.count', -1) do
      delete :destroy, id: @benchmark_test
    end

    assert_redirected_to benchmark_tests_path
  end
end
