require 'rails_helper'

RSpec.describe Scale, :type => :model do
  let(:scale) {
    Scale.create(
      :name => "Major",
      :scale_type => "Standard",
      :origin => "Western",
      :pattern => "2212221",
      :melody_rules => "Notes can be played in any order"
    )
  }

  it "is valid with a name, scale_type, origin, pattern and melody_rules" do
    expect(scale).to be_valid
  end

  it "has many practises" do
    musician = Musician.create(name: "Beth Schofield", password: "password")
    practise = Practise.create(musician_id: musician.id, scale_id: scale.id)
    expect(scale.practises.first).to eq(practise)
  end

  it "has many musicians through practises" do
    aki = Musician.create(name: "Al Gakovic", password: "password")
    beti = Musician.create(name: "Beth Schofield", password: "password")
    scale.musicians << [aki, beti]

    expect(scale.musicians.first).to eq(aki)
    expect(scale.musicians.last).to eq(beti)
  end

  it "can, given a starting midi value, create an array representing the scale starting on the given note, in midi values"
    root = 60
    expect(scale.automagic(root)).to eq([60, 62, 64, 65, 67, 69, 71, 72])
  end
end
