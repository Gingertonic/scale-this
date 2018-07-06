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

  it "tells you the last time you practised the scale - today" do
    expect(practise.status).to eq("today")
  end

  it "tells you the last time you practised the scale - yesterday" do
    practise.updated_at = Time.now - 1.day
    expect(practise.status).to eq("yesterday")
  end

  it "tells you the last time you practised the scale - this week" do
    practise.updated_at = Time.now - 2.days
    expect(practise.status).to eq("this week")
  end

  it "tells you the last time you practised the scale - this month" do
    practise.updated_at = Time.now - 2.weeks
    expect(practise.status).to eq("this month")
  end

  it "tells you the last time you practised the scale - ages ago" do
    practise.updated_at = Time.now - 2.months
    expect(practise.status).to eq("ages ago")
  end

end
