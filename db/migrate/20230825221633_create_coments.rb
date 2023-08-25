class CreateComents < ActiveRecord::Migration[7.0]
  def change
    create_table :coments do |t|
      t.references :author, foreign_key: { to_table: :users }
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
