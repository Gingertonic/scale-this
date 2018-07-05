class CreatePractises < ActiveRecord::Migration[5.2]
  def change
    create_table :practises do |t|

      t.timestamps
    end
  end
end
