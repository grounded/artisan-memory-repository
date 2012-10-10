require 'artisan/shared_examples/iteration_examples'
require 'artisan-memory-repository/iteration_repository'

describe ArtisanMemoryRepository::IterationRepository do
  it_behaves_like "iteration repository"
end
