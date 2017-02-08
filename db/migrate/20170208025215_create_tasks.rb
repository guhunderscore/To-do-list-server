class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :text
      t.string :aasm_state

      t.timestamps
    end
  end
end
