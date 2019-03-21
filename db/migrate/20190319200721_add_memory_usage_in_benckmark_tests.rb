class AddMemoryUsageInBenckmarkTests < ActiveRecord::Migration
  def change
    add_column :benchmark_tests, :memory_usage, :decimal
  end
end
