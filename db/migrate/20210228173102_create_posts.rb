class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.text :content
      t.text :description
      t.string :output_type
      t.integer :language_id
      t.string :language_version
      t.string :framework
      t.string :title
      t.string :inputs
      t.timestamps null: false
    end
  end
end
