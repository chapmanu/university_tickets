module UniversityTickets
  class Ticket
    attr_accessor :name, :price, :remaining

    # Initializes a new Ticket object with the parsed JSON from the API.
    #
    # @param hash [HASH] parsed event JSON from the API feed
    # @return [UniversityTickets::Ticket]
    def initialize(hash)
      hash.each do |key, value|
        attribute = ATTRIBUTE_MAP[key.to_s]
        send("#{attribute}=", value) if respond_to?(attribute)
      end
    end

    private

    # Maps the keys for the raw JSON API to the attributes to attribute names
    ATTRIBUTE_MAP = {
      'Ticket Name' => :name,
      'Price'       => :price,
      'Remaining'   => :remaining
    }
  end
end