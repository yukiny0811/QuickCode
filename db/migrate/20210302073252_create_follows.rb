class CreateFollows < ActiveRecord::Migration[5.2]
  def change
    create_table :follows do |t|
      t.integer :follow_from
      t.integer :follow_to
      t.timestamps null: false
    end
  end
end
