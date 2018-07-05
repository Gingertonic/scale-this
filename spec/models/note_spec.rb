require 'rails_helper'

RSpec.describe Note, :type => :model do
  let(:note) {
    Note.create(
      :name => "C",
      :midi_value => 60
    )
  }

  it "is valid with a name and midi_value" do
    expect(note).to be_valid
  end


end
