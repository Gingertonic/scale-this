class AddAdminToMusicians < ActiveRecord::Migration[5.2]
  def change
    add_column :musicians, :admin, :boolean, default: false
  end
end
