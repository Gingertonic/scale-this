class AddAkaToScales < ActiveRecord::Migration[5.2]
  def change
    add_column :scales, :aka, :string
  end
end
