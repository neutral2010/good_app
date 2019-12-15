class AddPictureToMocroposts < ActiveRecord::Migration[5.1]
  def change
    add_column :mocroposts, :picture, :string
  end
end
