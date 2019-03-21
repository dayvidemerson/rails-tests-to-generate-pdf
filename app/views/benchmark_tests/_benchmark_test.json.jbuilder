json.extract! benchmark_test, :id, :description, :from, :url, :user_cpu_time, :system_cpu_time, :total_cpu_time, :real_cpu_time, :created_at, :updated_at
json.url benchmark_test_url(benchmark_test, format: :json)
