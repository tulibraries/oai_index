# OaiIndex
[![Build Status](https://travis-ci.org/tulibraries/oai_index.svg?branch=main)](https://travis-ci.org/tulibraries/oai_index)
[![Coverage Status](https://coveralls.io/repos/github/tulibraries/oai_index/badge.svg?branch=main)](https://coveralls.io/github/tulibraries/oai_index?branch=main)

Oai Index is a repository to hold the traject configuration files and scripts
associated with indexing for dpla oai server.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'oai_index'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install oai_index

## Usage

`oai_index` is an executable.  You can use it to ingest files into SOLR_URL with

```
oai_index ingest $path_to_file
```

`$path_file` can also be a URL.


### Ingest switches
`--commit` If this switch is passed (`oai_index ingest --commit`), then oai_index will send commit at end of ingest process.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tulibraries/oai_index. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CobIndex project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/tulibraries/oai_index/blob/main/CODE_OF_CONDUCT.md).
