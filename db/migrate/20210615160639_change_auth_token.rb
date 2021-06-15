class ChangeAuthToken < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :auth_token, :api_key
  end
end
