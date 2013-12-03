# Gistify

[![Version](http://allthebadges.io/garciadanny/gistify/badge_fury.png)](http://allthebadges.io/garciadanny/gistify/badge_fury)
[![Dependencies](http://allthebadges.io/garciadanny/gistify/gemnasium.png)](http://allthebadges.io/garciadanny/gistify/gemnasium)
[![Build Status](https://travis-ci.org/garciadanny/gistify.png?branch=master)](https://travis-ci.org/garciadanny/gistify)
[![Coverage](http://allthebadges.io/garciadanny/gistify/coveralls.png)](http://allthebadges.io/garciadanny/gistify/coveralls)
[![Code Climate](http://allthebadges.io/garciadanny/gistify/code_climate.png)](http://allthebadges.io/garciadanny/gistify/code_climate)

#### Gistify allows you to create gists from the command line.

###### If you've used Gistify, I would love some feedback on how I could make it better. Thanks!

## Installation

Add this line to your application's Gemfile:

    gem 'gistify'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gistify

## Usage

##### Login

You'll first need to create an oauth token to create gists:

	$ gistify login

This will display a prompt asking you for your GitHub username and password:

	GitHub username:
	password:

If you are successfully authenticated, gistify will create a `.gistify` file containing your oauth token in your home directory `~/`. This file will be accessed by gistify when creating your gists.

##### List

You can also view a list of all your public and private gists by running:

	$ gistify list

This will display a table of the gist's name, description, and url.

##### File

To create a gist, first `cd` into the directory containing your file, then run:

	$ gistify file [FILENAME]

This will create your gist and return it's url.

You can optionally include a description as well:

	$ gistify file [FILENAME] -d 'some description'
or

	$ gistify file [FILENAME] --description 'some description'


For a list of all the available commands:

	$ gistify help

## Contributing


1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Run `rake setup:vcr_directory` to use VCR in your specs.
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
