class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.integer :state
      t.string :name
      t.text :description
      t.uuid :project_id, index: true, foreign_key: true, default: 'uuid_generate_v4()'

      t.timestamps null: false
    end
  end
end
