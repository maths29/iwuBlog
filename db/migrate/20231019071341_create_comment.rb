class CreateComment < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.string :text

      t.timestamps
    end
  end
end
