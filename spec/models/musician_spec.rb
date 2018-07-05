RSpec.describe Musician, :type => :model do
  let(:musician) {
    Musician.create(
      :name => "Beth Schofield",
      :email => "thegingertonicstudios@gmail.com",
      :provider => "visagetome",
      :uid => "123",
      :image_url => "www.image.com/photo.png"
      :password => "password"
    )
  }

  it "is valid with a name, email, provider, uid, image_url and password" do
    expect(musician).to be_valid
  end

  it "has many practises" do
    scale = Scale.create(name: "Major", pattern: "2212221")
    practise = Practise.create(musician_id: musician.id, scale_id: scale.id)
    expect(musician.practise.first).to eq(practise)
  end

  it "has many scales through practises" do
    dorian = Scale.create(name: "Dorian", pattern: "2122212")
    lydian = Scale.create(name: "Lydian", pattern: "2221221")
    musician.scales << [dorian, lydian]

    expect(scale.users.first).to eq(dorian)
    expect(scale.users.last).to eq(lydian)
  end

end
