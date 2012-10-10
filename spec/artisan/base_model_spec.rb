require 'artisan-memory-repository/models/base'

class TestBaseModel < ArtisanMemoryRepository::Base
  data_attributes :name, :age, :married

  boolean :married
end

describe TestBaseModel do
  context ".data_attributes" do
    it "creates a setter/getter for each data attribute" do
      mock = TestBaseModel.new
      mock.respond_to?(:name).should be_true
      mock.respond_to?(:name=).should be_true
    end
  end

  context "#saves?" do
    it "id is nil if model does not save" do
      mock = TestBaseModel.new(:saves => false)

      mock.saves?.should be_false
      mock.id.should be_nil
    end

    it "id is set if model does saves" do
      mock = TestBaseModel.new

      mock.saves?.should be_true
      mock.id.should_not be_nil
    end

    it "update attributes returns false if saves is false" do
      mock = TestBaseModel.new(:saves => false)
      mock.saves.should be_false
      mock.update_attributes({:test_attr => "goodbye"}).should == false
    end
  end

  context ".boolean" do
    it "returns false for #attribute? if attribute is false" do
      mock = TestBaseModel.new(:married => false)
      mock.married?.should be_false
    end

    it "returns true for #attribute? if attribute is true" do
      mock = TestBaseModel.new(:married => true)
      mock.married?.should be_true
    end
  end

  it "sets attributes based on options hash" do
    mock = TestBaseModel.new(:name => "Bob", :age => 42)
    mock.name.should == "Bob"
    mock.age.should == 42
  end

  it "#update_attribute changes the value for the given attr" do
    mock = TestBaseModel.new(:name => "Bob")
    mock.update_attribute(:name, "Joe")
    mock.name.should == "Joe"
  end

  it "#update_attributes takes a hash of values to change" do
    mock = TestBaseModel.new(:name => "Bob")
    mock.update_attributes(:name => "Joe", :age => 22)
    mock.name.should == "Joe"
    mock.age.should == 22
  end
end
