require 'rails_helper'

RSpec.describe Practise, :type => :model do


  let(:practise) {
    Practise.create(
      :musician_id => 1,
      :scale_id => 2
    )
  }


  it "is valid with a musician_id and scale_id" do
    expect(practise).to be_valid
  end

  it "has a default experience value of 1" do
    expect(practise.experience).to eq(1)
  end


end
