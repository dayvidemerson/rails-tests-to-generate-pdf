class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
      t.string :name
      t.decimal :salary
      t.date :admission_date

      t.timestamps null: false
    end
  end
end
