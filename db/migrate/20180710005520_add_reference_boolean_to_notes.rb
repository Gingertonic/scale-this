class AddReferenceBooleanToNotes < ActiveRecord::Migration[5.2]
  def change
    add_column :notes, :reference, :boolean, default: false
  end
end
