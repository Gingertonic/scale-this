class AddFrequencyToNotes < ActiveRecord::Migration[5.2]
  def change
    add_column :notes, :frequency, :float
  end
end
