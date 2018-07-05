class CreatePractises < ActiveRecord::Migration[5.2]
  def change
    create_table :practises do |t|
      t.integer :musician_id
      t.integer :scale_id
      t.integer :experience, default: 1
      t.timestamps
    end
  end
end
