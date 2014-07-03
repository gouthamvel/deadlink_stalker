require 'bundler/setup'
require "anemone"
require 'csv'

class Deadlink < Thor
  desc "Uri for the website", "an example task"
  def stalk(url)
    @line_seprator = "\n"
    @dead_links = []
    begin
      @uri = URI.parse(url =~ /\Ahttp.*/ ? url : "http://#{url}")
    rescue => e
      raise "Malformed URL provided :#{url}"
    end
    @valid_link_regx = ::Regexp.union /http[s]?:\/\/#{@uri.host}.*/, /http[s]?:\/\/www.#{@uri.host}.*/

    ::Anemone.crawl(url) do |anemone|

      anemone.focus_crawl do |page|
        page.links.map {|link| link.to_s =~ @valid_link_regx ? link : nil }.compact
      end

      anemone.on_every_page do |page|
        STDERR << "Failed to fetch #{page.url.to_s}" if page.error.is_a? SocketError
        @dead_links << page.url.to_s if page.code == 404
      end

      anemone.after_crawl do |page|
        STDOUT << @dead_links.to_csv(col_sep: @line_seprator)
      end
    end
  end
end
