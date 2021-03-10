class CreateInjections < ActiveRecord::Migration[6.0]
  def change
    create_table :injections do |t|
      t.date :performed_at
      t.references :user, null: false, foreign_key: true
      t.references :disease, null: false, foreign_key: true

      t.timestamps
    end
  end
end
