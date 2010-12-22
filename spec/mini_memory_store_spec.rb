require File.expand_path('spec/spec_helper')

describe MiniMemoryStore do
  let(:store){ MiniMemoryStore.new }

  it "has a VERSION" do
    MiniMemoryStore::VERSION.should =~ /^\d+\.\d+\.\d+$/
  end

  it "is nil when not set" do
    store.get.should == nil
  end

  it "can store a value" do
    store.set 1
    store.get.should == 1
  end

  it "can cache a value" do
    store.cache{1}.should == 1
    store.cache{2}.should == 1
  end

  it "can cache false" do
    store.cache{false}.should == false
    store.cache{1}.should == false
  end

  it "does not cache nil" do
    store.cache{nil}.should == nil
    store.cache{1}.should == 1
  end

  it "clears" do
    store.set 1
    store.clear
    store.get.should == nil
  end

  it "does not expire" do
    store.set 1
    sleep 1
    store.get.should == 1
  end

  it "expires after given time" do
    store = MiniMemoryStore.new(:expires_in => 1)
    store.set 1
    store.get.should == 1
    sleep 1
    store.get.should == nil
  end

  it "expires immediately with expires_in => 0" do
    store = MiniMemoryStore.new(:expires_in => 0)
    store.set 1
    store.get.should == nil
  end
end