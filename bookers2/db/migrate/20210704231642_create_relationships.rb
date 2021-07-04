class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.integer :follower_id 
      t.integer :followed_id
      
      t.references :user
      t.references :follower, foreign_key: { to_table: :users }

      t.timestamps
      
      t.index [:user_id, :follower_id], unique: true
    end
  end
end
