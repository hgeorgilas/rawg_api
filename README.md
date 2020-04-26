# RawgApi

RawgApi gem is a ruby wrapper for the [rawg.io](https://rawg.io/) REST API.

It exposes every endpoint through the `RawgApi::Clients` interface 
that returns raw responses from the API. 

Moreover it provides a `RawgApi::Entities` interface that will return serialized data
for every endpoint using the [Hashie](https://github.com/hashie/hashie) gem
## Installation

Ruby required: `>= 2.5.0`

Add this line to your application's Gemfile:


```ruby
gem 'rawg_api'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rawg_api

## Configuration
You can configure your default settings using
```
RawgApi.configure do |config|
  # No need to change the endpoint, this option was provided
  # to override the endpoint in the future 
  # if there is a need to do so
  config.endpoint = 'https://api.rawg.io/api'

  # This is mandatory and going to be appended
  # to the headers of each request
  config.app_name = 'Your app name' 

  # Any custom headers in JSON format 
  config.headers = {}

  # Default page size for results returned by the API
  config.page_size = 50
end
```

## Usage

#### Clients
You can access any resource on [rawg.io](https://rawg.io/) using the `RawgApi::Clients` interface
Most of these clients expose `#find` and `#all` methods, with the exception of the `RawgApi::Clients::Games`
which also exposes a `#search` method.

Responses are wrapped around `Success` or `Failure` structures provided by [dry-monads](https://github.com/dry-rb/dry-monads)
In order to fetch the actual values as `Hash` you will have to call `#value!` on the response
#### Using Clients
```
# General Usage
response = RawgApi::Clients::{CLIENT_NAME}.new.{METHOD} # returns Success/Failure
result = response.value! # returns Hash

# Get all games
response = RawgApi::Clients::Games.new.all
result = response.value! 

# Set page and page_size. 
# Returns the second page of the results with a limit of 20 resources per page
# page_size defaults to the page_size you have set on your configuration
response = RawgApi::Clients::Games.new.all(page:2, page_size: 20)

# Search for a game
response = RawgApi::Clients::Games.new.search(title: 'Portal 2')
result = response.value!

# Get game by id
# Get The Witcher 3 details
response = RawgApi::Clients::Games::Details.new.find(3328)
result = response.value!

# Find with pagination
RawgApi::Clients::Games::Additions.new.find(3328, page:1, page_size:1)
```
#### Using `Rawg::Api::Clients::Games#search` with multiple filters criteria
`#search` accepts the following arguments
- `page`:`Integer`
- `page_size`:`Integer`
- `title`:`String`
- `exclude_collection`:`Boolean`
- `exclude_parents`:`Boolean`
- `exclude_game_series`:`Boolean`
- `parent_platforms`:`Array`
- `platforms`:`Array`
- `stores`:`Array`
- `developers`:`Array`
- `publishers`:`Array`
- `genres`:`Array`
- `tags`:`Array`
- `creators`:`Array`
- `dates`:`Array`
- `platforms_count`:`Array`
- `order`:`String` 
    - Ascending: `name`, `release`, `added`, `created`, `rating`
    - Descending: `-name`, `-release`, `-added`, `-created`, `-rating`


#### List of clients and methods
- `RawgApi::Clients::Genres`: `#find`,`#all`
- `RawgApi::Clients::Publishers`: `#find`,`#all`
- `RawgApi::Clients::Platforms`: `#find`,`#all`
- `RawgApi::Clients::Creators`: `#find`,`#all`
- `RawgApi::Clients::Developers`: `#find`,`#all`
- `RawgApi::Clients::Stores`: `#find`,`#all`
- `RawgApi::Clients::CreatorRoles`: `#all`
- `RawgApi::Clients::Tags`: `#all`
- `RawgApi::Clients::ParentPlatforms`: `#all`
- `RawgApi::Clients::TagDetails`: `#find`
- `RawgApi::Clients::Games`: `#all`, `#search`
- `RawgApi::Clients::Games::Achievements`: `#find`
- `RawgApi::Clients::Games::Twitch`: `#find`
- `RawgApi::Clients::Games::SuggestedGames`: `#find`
- `RawgApi::Clients::Games::Stores`: `#find`
- `RawgApi::Clients::Games::DevelopmentTeam`: `#find`
- `RawgApi::Clients::Games::Series`: `#find`
- `RawgApi::Clients::Games::Trailers`: `#find`
- `RawgApi::Clients::Games::ParentGames`: `#find`
- `RawgApi::Clients::Games::Additions`: `#find`
- `RawgApi::Clients::Games::Details`: `#find`
- `RawgApi::Clients::Games::Youtube`: `#find`
- `RawgApi::Clients::Games::Screenshots`: `#find`
- `RawgApi::Clients::Games::Reddit`: `#find`

#### Using Entities
You can also use `Entities` to receive a serialized response.

All methods declared in the clients can be invoked as class methods on the `Entity` class
and accept the same parameters as their `Client` counterpart. 
```
# General Usage
response = RawgApi::Entities::{ENTITY_NAME}.{METHOD} # returns Hashie Object
results = response.results

# Returns info regarding the request, such as current page, page size etc...
metadata = response.metadata 

# Get all games
response = RawgApi::Entities::Game::Entity.all
result = response.results 

# Set page and page_size. 
# Returns the second page of the results with a limit of 20 resources per page
# page_size defaults to the page_size you have set on your configuration
response = RawgApi::Entities::Entity.all(page:2, page_size: 20)

# Search for a game
response = RawgApi::Clients::Game::Entity.search(title: 'Portal 2')

# Get game by id
response =  RawgApi::Entities::Game::Entity.find(3328)

# Access value by attribute
response.name # => "The Witcher 3: Wild Hunt"

# Find with pagination
RawgApi::Entities::Game::Additions.find(3328, page:1, page_size:1)
```

`RawgApi::Entities::Game::Entity` has the ability to delegate methods to other entities

```
# Get additions through RawgApi::Entities::Game::Entity class

# Returns game additions for The Witcher 3
RawgApi::Entities::Game::Entity.find_additions(3328)

# Returns tags for The Witcher 3
RawgApi::Entities::Game::Entity.find_tags(3328)

```
#### List of entities and methods

- `RawgApi::Entities::Genres`: `#find`,`#all`
- `RawgApi::Entities::TagDetails`: `#find`
- `RawgApi::Entities::Developer`: `#find`,`#all`
- `RawgApi::Entities::Creator`: `#find`,`#all`
- `RawgApi::Entities::CreatorRole`: `#all`
- `RawgApi::Entities::Store`: `#find`,`#all`
- `RawgApi::Entities::Platform`: `#find`,`#all`
- `RawgApi::Entities::Publisher`: `#find`,`#all`
- `RawgApi::Entities::Tag`: `#all`,`#find`
- `RawgApi::Entities::Game::Achievements`: `#find`
- `RawgApi::Entities::Game::YouTube`: `#find`
- `RawgApi::Entities::Game::Twitch`: `#find`
- `RawgApi::Entities::Game::SuggestedGames`: `#find`
- `RawgApi::Entities::Game::Stores`: `#find`
- `RawgApi::Entities::Game::DevelopmentTeam`: `#find`
- `RawgApi::Entities::Game::Series`: `#find`
- `RawgApi::Entities::Game::Entity`: 
  - `#find`,`#all`,`#search`,`#find_suggested_games`,`#find_series`,
  - `#find_screenshots`,`#find_stores`,`#find_reddit`,`#find_additions`,
  - `#find_youtube`,`#find_twitch`, `#find_achievements`
- `RawgApi::Entities::Game::Details`: `#find`
- `RawgApi::Entities::Game::Trailers`: `#find`
- `RawgApi::Entities::Game::ParentGames`: `#find`
- `RawgApi::Entities::Game::Additions`: `#find`
- `RawgApi::Entities::Game::Screenshots`: `#find`
- `RawgApi::Entities::Game::Reddit`: `#find`


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Debugging
Create an `.env` file on your root directory and add the following variable
```
ENVIRONMENT=development
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hgeorgilas/rawg_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/rawg_api/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RawgApi project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/hgeorgilas/rawg_api/blob/master/CODE_OF_CONDUCT.md).
