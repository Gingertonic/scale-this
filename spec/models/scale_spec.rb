require 'rails_helper'

RSpec.describe Scale, :type => :model do

  before(:each) do
    Note.create(name: "C4", midi_value: 60, frequency: 261.63)
    Note.create(name: "D4", midi_value: 62, frequency: 293.66)
    Note.create(name: "E4", midi_value: 64, frequency: 329.63)
    Note.create(name: "F4", midi_value: 65, frequency: 349.23)
    Note.create(name: "G4", midi_value: 67, frequency: 392.00)
    Note.create(name: "A4", midi_value: 69, frequency: 440.00)
    Note.create(name: "B4", midi_value: 71, frequency: 493.88)
    Note.create(name: "C5", midi_value: 72, frequency: 523.25)
    Note.create(name: "D5", midi_value: 74, frequency: 587.33)
    Note.create(name: "E5", midi_value: 76, frequency: 659.25)
    Note.create(name: "F5", midi_value: 77, frequency: 698.46)
    Note.create(name: "G5", midi_value: 79, frequency: 783.99)
    Note.create(name: "A5", midi_value: 81, frequency: 880.00)
    Note.create(name: "B5", midi_value: 83, frequency: 987.77)
    Note.create(name: "C6", midi_value: 84, frequency: 1046.50)
  end


  let(:scale) {
    Scale.create(
      :name => "Major",
      :scale_type => "Standard",
      :origin => "Western",
      :pattern => "2212221",
      :melody_rules => "Notes can be played in any order"
    )
  }

  let(:custom_scale) {
    Scale.create_custom(
        :name => "Sweet new scale",
        :scale_type => "Amazing",
        :origin => "My brain",
        :pattern => [58, 59, 61, 62, 64, 65],
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

  # it "can, given a starting midi value, create an array representing 1 octave of the scale starting on the given note, in midi values" do
  #   root = 60
  #   expect(scale.scale_generator(root, 1)).to eq([60, 62, 64, 65, 67, 69, 71, 72])
  # end
  #
  # it "can, given a starting midi value, create an array representing 2 octaves of the scale starting on the given note, in midi values" do
  #   root = 60
  #   expect(scale.scale_generator(root, 2)).to eq([60, 62, 64, 65, 67, 69, 71, 72, 74, 76, 77, 79, 81, 83, 84])
  # end

  it "can, given a starting midi value, provide the frequencies for 1 octaves worth of the scale" do
    expect(scale.scale_generator(60, 1)).to eq([261.63, 293.66, 329.63, 349.23, 392.00, 440.00, 493.88, 523.25])
  end

  it "can, given a starting midi value, provide the frequencies for 2 octaves worth of the scale" do
    expect(scale.scale_generator(60, 2)).to eq([261.63, 293.66, 329.63, 349.23, 392.00, 440.00, 493.88, 523.25, 587.33, 659.25, 698.46, 783.99, 880.00, 987.77, 1046.50])
  end

  it "can create a new scale based on a custom midi note pattern" do
    expect(custom_scale.pattern).to eq("12121")
  end
end
