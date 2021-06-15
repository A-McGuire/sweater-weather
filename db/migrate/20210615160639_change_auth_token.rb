class ChangeAuthToken < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :api_key, :api_key
  end
end
