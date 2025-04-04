require 'active_record'
require 'active_buddy'

class Dummy < ActiveRecord::Base
  self.table_name = 'dummies'
end

RSpec.describe ActiveBuddy::Analyzer do
  before(:all) do
    ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: ':memory:'
    )

    ActiveRecord::Schema.define do
      create_table :dummies, force: true do |t|
        t.string :email, null: false
        t.string :name
        t.string :phone
        t.text :bio
        t.integer :age
        t.decimal :price
        t.string :password
        t.timestamps
      end
    end
  end

  it 'suggests validations for typical columns' do
    analyzer = ActiveBuddy::Analyzer.new(Dummy)
    validations = analyzer.suggest_validations

    expect(validations).to include("validates :email, format: { with: /\\A[^@\\s]+@[^@\\s]+\\.[^@\\s]+\\z/ }")
    expect(validations).to include("validates :email, presence: true")
    expect(validations).to include("validates :name, presence: true")
    expect(validations).to include("validates :bio, length: { maximum: 1000 }")
    expect(validations).to include("validates :price, numericality: { greater_than_or_equal_to: 0 }")
  end
end
