class AddSolfegeToNotes < ActiveRecord::Migration[5.2]
  def change
    add_column :notes, :solfege, :string
  end
end
