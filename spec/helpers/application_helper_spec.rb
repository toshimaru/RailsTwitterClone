require 'rails_helper'

describe ApplicationHelper do
  it { expect(full_title("title")).to eq "title | Twitter Clone" }
  it { expect(full_title("")).to eq "Twitter Clone" }
end
