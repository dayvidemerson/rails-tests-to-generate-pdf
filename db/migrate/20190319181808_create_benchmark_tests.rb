class CreateBenchmarkTests < ActiveRecord::Migration
  def change
    create_table :benchmark_tests do |t|
      t.string :description
      t.string :from
      t.string :url
      t.decimal :user_cpu_time
      t.decimal :system_cpu_time
      t.decimal :total_cpu_time
      t.decimal :real_cpu_time

      t.timestamps null: false
    end
  end
end
