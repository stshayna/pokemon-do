class AddSpeciesToPokemons < ActiveRecord::Migration[6.1]
  def change
    add_column :pokemons, :species, :string
  end
end
