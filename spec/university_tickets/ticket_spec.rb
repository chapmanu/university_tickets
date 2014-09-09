require 'json'

describe UniversityTickets::Ticket do
  let(:json)        { File.read(File.join(SAMPLES, 'ticket_types.json')) }
  let(:ticket_hash) { JSON.parse(json)[0] }
  subject(:ticket)  { UniversityTickets::Ticket.new(ticket_hash) }

  it { is_expected.to have_attributes(:name      => 'General Admission') }
  it { is_expected.to have_attributes(:price     => '10.00') }
  it { is_expected.to have_attributes(:remaining =>  185) }
end