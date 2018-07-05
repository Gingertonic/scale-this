class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.string :name
      t.integer :midi_value
      t.timestamps
    end
  end
end
