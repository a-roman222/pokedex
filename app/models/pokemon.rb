class Pokemon < ApplicationRecord
  # Associations
  belongs_to :generation

  has_many :pokemon_types
  has_many :types, through: :pokemon_types

  has_many :pokemon_abilities
  has_many :abilities, through: :pokemon_abilities

  # Validations
  validates :name, presence: true
  validates :pokedex, presence: true, uniqueness: true
  validates :weight_kg, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :hp, :attack, :defense, :sp_attack, :sp_defense, :speed, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
end
