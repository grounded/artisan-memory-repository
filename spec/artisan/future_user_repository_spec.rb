require 'artisan/repository'
require 'artisan/shared_examples/future_user_examples'
require 'artisan/spec_helper'

describe ArtisanMemoryRepository::FutureUserRepository do
  it_behaves_like "future user repository"
end
