class CreateReadLaters < ActiveRecord::Migration[5.1]
  def change
    create_table :read_laters do |t|
      t.string :url

      t.timestamps
    end
  end
end
