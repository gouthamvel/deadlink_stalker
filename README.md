# Deadlink Stalker


Cli tool to export all the internal dead links for a domain.

### Basic usage details
----
Accepts only single domain, subdomain are excluded when root domain is given(with an exception of www, which get included by default with every domain).

If a path is given with the domain, the crawl start from the path but is not restricted with in the path.
i.e; if https://github.com/gouthamvel/deadlink_stalker was passed as the command line argument, the tool would check for https://github.com/login https://github.com/join as well.

The results are sent to the standard output(STDOUT) and if any errors they are pushed to the standard error(STDERR) streams.

The output is links separated by new line char(```\n```)

### How to run

	$ git clone https://github.com/gouthamvel/deadlink_stalker.git
	$ cd deadlink_stalker
	$ bundle install

	$ bundle exec thor deadlink:stalk  http://loremipsum.net 1>./deadlinks.txt 2>./errors.log


### Dependencys

* thor
* anemone

### Thoughts further development

* Abstract it away & wright some tests
* Wrap it in a gem with executables
* Support for path restrictions
* 