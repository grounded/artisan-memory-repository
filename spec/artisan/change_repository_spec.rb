require 'artisan/shared_examples/change_examples'
require 'artisan-memory-repository/change_repository'

describe ArtisanMemoryRepository::ChangeRepository do
  it_behaves_like "change repository"
end
