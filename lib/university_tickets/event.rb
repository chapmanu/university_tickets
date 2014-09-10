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
    end

    def tickets=(array)
      @tickets = array.map{|ticket_json| UniversityTickets::Ticket.new(ticket_json) }
    end

    private

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
