require File.expand_path('spec/spec_helper')

describe MiniMemoryStore do
  it "has a VERSION" do
    MiniMemoryStore::VERSION.should =~ /^\d+\.\d+\.\d+$/
  end
end
