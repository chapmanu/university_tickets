module UniversityTickets
  class Event
    attr_accessor :id, :title, :datetime, :description, :venue, :pricing, :url, :quantity, :tickets, :last_modified

    # Initializes a new Event object with the parsed JSON from the API.
    #
    # @param hash [HASH] parsed event JSON from the API feed
    # @return [UniversityTickets::Event]
    def initialize(hash)
      hash.each do |key, value|
        attribute = ATTRIBUTE_MAP[key.to_s]
        send("#{attribute}=", value) if (attribute && respond_to?(attribute))
      end
      make_prices_negative if pricing.downcase == 'variable'
    end

    def tickets=(array)
      @tickets = array.map{|ticket_json| UniversityTickets::Ticket.new(ticket_json) }
    end

    private

    # When pricing is 'variable' the actual ticket costs are irrelevant because
    # the ticket is based on the seat that the user chooses.
    def make_prices_negative
      tickets.each{|ticket| ticket.price = -1}
    end

    # Maps the keys for the raw JSON API to the attributes to attribute names
    ATTRIBUTE_MAP = {
       'Event ID'        => :id,
       'Event Title'     => :title,
       'Event Date/Time' => :datetime,
       'Description'     => :description,
       'Venue'           => :venue,
       'Pricing'         => :pricing,
       'URL'             => :url,
       'Quantity'        => :quantity,
       'Tickets'         => :tickets,
       'Last_Modified'   => :last_modified
    }
  end
end
