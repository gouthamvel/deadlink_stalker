require 'bundler/setup'
require "anemone"
require 'yaml'

class Deadlink < Thor
  desc "Uri for the website", "an example task"
  def stalk(url)
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

      anemone.after_crawl do |pages|
        output = {}
        unless @dead_links.empty?
          missing_links = pages.urls_linking_to(@dead_links)
          missing_links.each do |url, links|
            encoded_url = CGI.escape(url.to_s)
            output[encoded_url] ||= []
            links.each do |u|
              output[encoded_url] << CGI.escape(u.to_s)
            end
          end
        end
        puts output.to_yaml
      end
    end
  end
end
