class AddCreatedbyAndPrivateToScales < ActiveRecord::Migration[5.2]
  def change
    add_column :scales, :created_by, :integer
    add_column :scales, :private, :boolean, default: true
  end
end
