class CreatePokemons < ActiveRecord::Migration[6.1]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.text :description
      t.string :location
      t.integer :price
      t.string :status, default: 'Available'
      # t.references :user, null: false, foreign_key: true ajouter migration avec addusertopokemon

      t.timestamps
    end
  end
end
