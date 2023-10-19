class CreatePost < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :Title
      t.text :text
      t.integer :CommentsCounter
      t.integer :LikesCounter
      
      t.timestamps
    end
  end
end
