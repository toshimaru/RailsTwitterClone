require 'rails_helper'

describe ApplicationHelper do
  it { expect(full_title("title")).to eq "title | Twitter Clone" }
end
