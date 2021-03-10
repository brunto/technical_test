require 'rails_helper'

RSpec.describe User, type: :model do
  before :all do
    @disease = Disease.find_or_create_by!(name: 'COVID 19')
  end

  it "is valid a user record" do
    user = User.create(name: "John Doe", birthdate: "1980-10-20")
    expect(user).to be_valid
  end

  it "is valid under 14 years old" do
    user = User.create(name: "John Doe Junior", birthdate: "2010-08-17")
    Injection.create(user: user, disease: @disease, performed_at: (Time.now - 12.months ))
    Injection.create(user: user, disease: @disease, performed_at: (Time.now - 6.months ))
    expect(user.verify).to be_truthy
  end

  it "is not valid under 14 years old" do
    user = User.create(name: "John Doe Junior", birthdate: "2010-08-17")
    Injection.create(user: user, disease: @disease, performed_at: (Time.now - 12.months ))
    Injection.create(user: user, disease: @disease, performed_at: (Time.now - 7.months ))
    expect(user.verify).to be_falsey
  end

  it "is valid between 14 years old and 65 years old" do
    user = User.create(name: "John Doe Brother", birthdate: "2006-03-10")
    Injection.create(user: user, disease: @disease, performed_at: (Time.now - 36.months ))
    expect(user.verify).to be_truthy
  end

  it "is not valid between 14 years old and 65 years old" do
    user = User.create(name: "John Doe Brother", birthdate: "2006-03-10")
    Injection.create(user: user, disease: @disease, performed_at: (Time.now - 37.months ))
    expect(user.verify).to be_falsey
  end

  it "is valid upper 65 years old" do
    user = User.create(name: "John Doe Grandfather", birthdate: "1955-03-10")
    Injection.create(user: user, disease: @disease, performed_at: (Time.now - 12.months ))
    expect(user.verify).to be_truthy
  end

  it "is not valid upper 65 years old" do
    user = User.create(name: "John Doe Grandfather", birthdate: "1955-03-10")
    Injection.create(user: user, disease: @disease, performed_at: (Time.now - 13.months ))
    expect(user.verify).to be_falsey
  end
end
