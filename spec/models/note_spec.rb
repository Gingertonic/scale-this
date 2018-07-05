require 'rails_helper'

RSpec.describe Attraction, :type => :model do
  let(:note) {
    Note.create(
      :name => "C",
      :midi_value => 60
    )
  }

  it "is valid with a name and midi_value" do
    expect(scale).to be_valid
  end


end
