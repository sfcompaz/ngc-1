require 'rails_helper'

RSpec.describe "clubs/show", :type => :view do
  before(:each) do
    @club = assign(:club, Club.create!(
      :name => "Name",
      :abbrev => "Abbrev"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Abbrev/)
  end
end
