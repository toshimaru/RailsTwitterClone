require 'spec_helper'

describe Micropost do
  let(:user) { FactoryGirl.create(:user) }

  subject(:micropost) { user.microposts.build(content: "Lorem ipsum") }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { expect(micropost.user).to eq(user) }

  it { should be_valid }

  describe "when user_id is not present" do
    before { micropost.user_id = nil }
    it { should_not be_valid }
  end

end
