class CreateMusicians < ActiveRecord::Migration[5.2]
  def change
    create_table :musicians do |t|
      t.string :name
      t.string :email
      t.string :provider
      t.string :uid
      t.string :image_url
      t.string :password_digest
      t.timestamps
    end
  end
end
