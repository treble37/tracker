class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :state
      t.string :name
      t.text :description
      t.references :project, index: true

      t.timestamps null: false
    end
  end
end
