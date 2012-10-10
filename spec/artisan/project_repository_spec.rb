require 'artisan/shared_examples/project_examples'
require 'artisan-memory-repository/project_repository'

describe ArtisanMemoryRepository::ProjectRepository do
  it_behaves_like "project repository"
end
