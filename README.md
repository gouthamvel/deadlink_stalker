# Deadlink Stalker


Cli tool to export all the internal dead links for a domain.

### Basic usage details
----
Accepts only single domain, subdomain are excluded when root domain is given(with an exception of www, which get included by default with every domain).

If a path is given with the domain, the crawl start from the path but is not restricted with in the path.
i.e; if https://github.com/gouthamvel/deadlink_stalker was passed as the command line argument, the tool would check for https://github.com/login https://github.com/join as well.

The results (look for Output format for details) are sent to the standard output(STDOUT) and if any errors they are pushed to the standard error(STDERR) streams.

### How to run

	$ git clone https://github.com/gouthamvel/deadlink_stalker.git
	$ cd deadlink_stalker
	$ bundle install

	$ bundle exec thor deadlink:stalk  http://loremipsum.net 1>./deadlinks.txt 2>./errors.log


### Output format
The output is links hash in yaml format. A hash with keys as dead links and value of the key is a array of page links where the dead link is found

**All the links will be escaped**

    dead_link_1:
      - page_1_with_dead_link_1
      - page_2_with_dead_link_1
      - page_3_with_dead_link_1
    dead_link_2:
      - page_1_with_dead_link_2
      - page_2_with_dead_link_2

A Sample real world output.

    ---
    http%3A%2F%2Flocalhost%3A9090%2Ffoo%2Cbar.html:
      - http%3A%2F%2Flocalhost%3A9090%2F
      - http%3A%2F%2Flocalhost%3A9090%2Findex.html



### Dependencys

* thor
* anemone

### Thoughts further development

* Abstract it away & wright some tests
* Wrap it in a gem with executables
* Support for path restrictions
* Multiple output format
* Optional escape for urls in output
