class AddQuantityInBenchmarkTest < ActiveRecord::Migration
  def change
    add_column :benchmark_tests, :quantity, :integer
  end
end
