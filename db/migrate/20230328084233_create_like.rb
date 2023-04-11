class CreateLike < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :author, null: false, foreign_key:  { to_table: 'users', name: 'author_id' }, index: true
      t.references :post, null: false, foreign_key: true, index: true
      t.timestamps
    end
  end
end
