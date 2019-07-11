class CreatePokemons < ActiveRecord::Migration

  def change
    create_table :pokemons do |t|
      t.text :name
      t.integer :user_id
    end
  end

end
