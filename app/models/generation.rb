class Generation < ApplicationRecord
  has_many :pokemons

  validates :g_name, :g_number, presence: true, uniqueness: true
end
