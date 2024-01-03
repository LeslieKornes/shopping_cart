class AddRealUserForeignKeyToCart < ActiveRecord::Migration[7.0]
  def change
    # add_foreign_key :child_table, :parent_table, on_delete: :nullify
    add_foreign_key :carts, :users, null: true, on_delete: :cascade
  end
end
