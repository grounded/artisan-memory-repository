require 'artisan/shared_examples/user_examples'
require 'artisan-memory-repository/user_repository'

describe ArtisanMemoryRepository::UserRepository do
  it_behaves_like "user repository"
end
