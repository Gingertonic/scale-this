require 'rails_helper'

RSpec.describe Practise, :type => :model do
  let(:musician) {
    Musician.create(
      :name => "Beth Schofield",
      :email => "thegingertonicstudios@gmail.com",
      :provider => "visagetome",
      :uid => "123",
      :image_url => "www.image.com/photo.png",
      :password => "password"
    )
  }

  let(:scale) {
    Scale.create(
      :name => "Major",
      :scale_type => "Standard",
      :origin => "Western",
      :pattern => "2212221",
      :melody_rules => "Notes can be played in any order"
    )
  }

  let(:practise) {
    Practise.create(
      :musician_id => musician.id,
      :scale_id => scale.id
    )
  }


  it "is valid with a musician_id and scale_id" do
    expect(practise).to be_valid
  end

  it "has a default experience value of 1" do
    expect(practise.experience).to eq(1)
  end


end
