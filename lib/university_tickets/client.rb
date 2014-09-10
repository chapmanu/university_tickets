require 'time'
require 'json'

module UniversityTickets
  # @author James Kerr
  # @abstract The http client that will be connecting to the
  #   UniversityTickets JSON API.  This is powered by the Faraday
  #   Ruby gem.
  class Client
    include ::UniversityTickets::DateUtils

    attr_accessor :base_url

    # You can create a new client by passing a block
    # or by passing a hash of options
    #
    # @param options [Hash]
    # @return [UniversityTickets::Client]
    def initialize(options = {})
      options.each do |key, value|
        send(:"#{key}=", value)
      end
      yield(self) if block_given?
    end

    # Method to get a list of events from the API
    #
    # @param filter [Symbol, Hash]
    # @return [Array<UniversityTicket::Event>]
    def get_events(filter)
      if filter.is_a? Symbol
        get_events_between build_date_range_from_symbol(filter)
      elsif filter.is_a? Hash
        get_events_between build_date_range_from_hash(filter)
      end
    end

    def build_date_range_from_hash(hash)
      if hash.keys.length == 1 && hash[:on]
        start_date = Date.parse(hash[:on])
        { :start => start_date, :end => start_date + 1 }
      elsif hash.keys.length == 2 && hash[:start] && hash[:end]
        start_date = Date.parse(hash[:start])
        end_date   = Date.parse(hash[:end])
        { :start => start_date, :end => end_date }
      else
        raise "Invalid Date Range #{hash}"
      end
    rescue
      raise "Invalid Date Range #{hash}"
    end

    def build_date_range_from_symbol(phrase)
       today = Date.today
       case phrase
        when :today
          { :start => today.to_s, :end => (today + 1).to_s }
        when :tomorrow
          { :start => (today + 1).to_s, :end => (today + 2).to_s }
        when :this_week
          { :start => start_of_week.to_s, :end => end_of_week.to_s }
        when :this_month
          { :start => start_of_month.to_s, :end => end_of_month.to_s }
        when :this_year
          { :start => start_of_year.to_s, :end => end_of_year.to_s }
        else
          raise "Unknown Parameter: #{phrase}"
        end
    end

    def get_events_between(date_range)
      json = get('', date_range).body
      if json.empty?
        []
      else
        JSON.parse(json).map{|event_hash| UniversityTickets::Event.new(event_hash) }
      end
    end


  private
    # Returns a Faraday::Connection object
    #
    # @return [Faraday::Connection]
    def connection
      @connection ||= Faraday.new(url: base_url) do |f|
        f.request :url_encoded
        f.adapter Faraday.default_adapter
      end
    end

    # Perform a get request
    #
    # @param path [string]
    # @param params [Hash]
    # @return [Faraday::Env]
    def get(path, params = {})
      request(:get, path, params)
    end

    # The helper method for making all requests
    #
    # @param method [Symbol]
    # @param path [String]
    # @param params [Hash]
    # @return [Faraday::Env]
    def request(method, path, params)
      response = connection.send(method.to_sym, path, params)
      response.env
    end
  end
end



