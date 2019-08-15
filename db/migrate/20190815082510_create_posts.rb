class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text        :text
      t.integer     :area
      t.integer     :country
      t.integer     :duration
      t.integer     :user_id
      t.timestamps  null: true
    end
  end
end
