class ChangeColumnTofollowerss < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key 'followers', 'users'
  end
end
