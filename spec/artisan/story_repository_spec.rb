require 'artisan/repository'
require 'artisan/spec_helper'
require 'artisan/shared_examples/story_examples'
require 'artisan-memory-repository/artisan_memory_repository'

describe ArtisanMemoryRepository::StoryRepository do
  Artisan::Repository.register_repo(ArtisanMemoryRepository)
  it_behaves_like "story repository"
end
