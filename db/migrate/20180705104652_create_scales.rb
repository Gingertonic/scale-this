class CreateScales < ActiveRecord::Migration[5.2]
  def change
    create_table :scales do |t|
      t.string :name
      t.string :type
      t.string :origin, default: "Unknown"
      t.string :pattern
      t.string :melody_rules, default: "No special rules"
      t.timestamps
    end
  end
end
