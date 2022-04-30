class AddUserToPokemons < ActiveRecord::Migration[6.1]
  def change
    add_reference :pokemons, :user, null: false, foreign_key: true
  end
end
