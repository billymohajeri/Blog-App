class CreatePost < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :Title
      t.text :Text
      t.integer :CommentsCounter
      t.integer :LikesCounter
      t.timestamps
    end
  end
end
