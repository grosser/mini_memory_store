# frozen_string_literal: true
require_relative "test_helper"

SingleCov.covered!

describe MiniMemoryStore do
  let(:store) { MiniMemoryStore.new expires_in: 1 }

  it "has a VERSION" do
    MiniMemoryStore::VERSION.must_match /^[\.\da-z]+$/
  end

  it "is nil when not set" do
    store.get.must_be_nil
  end

  it "can store a value" do
    store.set 1
    store.get.must_equal 1
  end

  it "can cache a value" do
    store.cache { 1 }.must_equal 1
    store.cache { 2 }.must_equal 1
  end

  it "can cache false" do
    store.cache { false }.must_equal false
    store.cache { 1 }.must_equal false
  end

  it "does not cache nil" do
    store.cache { nil }.must_be_nil
    store.cache { 1 }.must_equal 1
  end

  it "clears" do
    store.set 1
    store.clear
    store.get.must_be_nil
  end

  it "does not expire" do
    store.set 1
    sleep 0.1
    store.get.must_equal 1
  end

  it "expires after given time" do
    store.set 1
    store.get.must_equal 1
    sleep 1
    store.get.must_be_nil
  end

  it "expires immediately with expires_in => 0" do
    store = MiniMemoryStore.new(expires_in: 0)
    store.set 1
    store.get.must_be_nil
  end
end
