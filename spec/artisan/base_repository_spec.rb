require 'artisan-memory-repository/base_repository'
require 'ostruct'

describe ArtisanMemoryRepository do
  class TestRepository
    extend ArtisanMemoryRepository::BaseRepository
  end

  describe TestRepository do
    let(:object) { OpenStruct.new(:id => nil, :name => "test") }
    let(:repo) { TestRepository }

    before { repo.destroy_all }

    context ".save" do
      it "should save to the database and set ID" do
        object.id.should be_nil
        saved = repo.save(object)

        saved.id.should_not be_nil
        saved.name.should == object.name
      end

      it "should increment the id for each object" do
        object2 = OpenStruct.new(:id => nil, :name => "test2")
        saved1 = repo.save(object)
        saved2 = repo.save(object2)

        saved2.id.should > saved1.id
      end

      it "doesn't rewrite existing ids" do
        object.id = 1
        saved = repo.save(object)
        object.id.should == 1
      end

      it "updates the attributes for an existing record" do
        saved = repo.save(object)
        saved.name = "Other Name"
        repo.save(saved)
        found = repo.find(saved.id)
        found.name.should == "Other Name"
      end
    end

    context ".find" do
      it "finds object by id" do
        saved = repo.save(object)
        repo.find(saved.id).should == saved
      end
    end

    context ".where" do
      it "finds by the given attributes" do
        saved = repo.save(object)
        repo.save(OpenStruct.new(:id => nil, :name => "shouldnt be found"))
        found = repo.where(:name => object.name)
        found.should == [saved]
      end

      it "finds by the given attributes with multiple keys" do
        object.api_key = "12345"
        saved = repo.save(object)
        found = repo.where(:name => object.name, :api_key => object.api_key)
        found.should == [saved]
      end
    end
  end
end
