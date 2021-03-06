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

		# Method to get a single event from the API by ID
		#
		# @param id [String, Integer]
		# @return [UniversityTickets::Event]
		def event(id)
			json = get('', id: id).body
			data = valid_json?(json) ? JSON.parse(json) : false
			data && data.length >= 1 ? UniversityTickets::Event.new(data[0]) : nil
		end

		# Method to get a list of events from the API
		#
		# @param filter [Symbol, Hash]
		# @param order [Hash]
		# @return [Array<UniversityTicket::Event>]
		def events(filter, order = {})
			if filter.is_a? Symbol
				events_between build_date_range_from_symbol(filter), order
			elsif filter.is_a? Hash
				events_between build_date_range_from_hash(filter), order
			end
		end

		########################################################
		private
		#########################################################

		# Fetches events from the University Tickets API within this date range
		#
		# @param date_range [Hash] with keys start: and end:
		# @param order [Hash]
		def events_between(date_range, order = {})
			json = get('', date_range.merge(order)).body
			parsed = valid_json?(json) ? JSON.parse(json) : false
			parsed ? JSON.parse(json).map{|event_hash| UniversityTickets::Event.new(event_hash) } : nil
		end

		# Creates a date range from a hash parameter
		#
		# @param hash [Hash]
		# @return [Hash]
		def build_date_range_from_hash(hash)
			if hash.keys.length == 1 && hash[:on]
				start_date = hash[:on].is_a?(Date) ? hash[:on] : Date.parse(hash[:on])
				{ :start => start_date, :end => start_date + 1 }
			elsif hash.keys.length == 2 && hash[:start] && hash[:end]
				start_date = hash[:start].is_a?(Date) ? hash[:start] : Date.parse(hash[:start])
				end_date   = hash[:end].is_a?(Date)   ? hash[:end]   : Date.parse(hash[:end])
				{ :start => start_date, :end => end_date }
			else
				raise "Invalid Date Range #{hash}"
			end
		rescue
			raise "Invalid Date Range #{hash}"
		end

		# Creates a common time phrase and constructs a hash date range
		#
		# @param phrase [Symbol]
		# @return [Hash]
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

		# Checks if a strings is valid JSON
		#
		# @param json [String]
		# @return [Boolean]
		def valid_json?(json)
			begin
				JSON.parse(json)
				return true
			rescue Exception => e
				return false
			end
		end
	end
end



