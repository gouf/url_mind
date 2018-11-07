class AddTitleColumnToReadlater < ActiveRecord::Migration[5.1]
  def up
    add_column :read_laters, :title, :string, null: false, default: ''
  end

  def down
    remove_column :read_laters, :title, :string, null: false, default: ''
  end
end
