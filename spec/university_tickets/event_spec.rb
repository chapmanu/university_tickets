require 'json'

describe UniversityTickets::Event do
  let(:json)       { File.read(File.join(SAMPLES, '2014_tickets.json')) }
  let(:event_hash) { JSON.parse(json)[0] }
  subject(:event)  { UniversityTickets::Event.new(event_hash) }

  it { is_expected.to have_attributes(:id          => '185') }
  it { is_expected.to have_attributes(:title       => 'Training - General Admission') }
  it { is_expected.to have_attributes(:datetime    => 'Friday, October 31, 2014 5:00 PM') }
  it { is_expected.to have_attributes(:description => '<p>This event will help demonstrate how a ticket can be sold to a general admission seating assignment event.</p>') }
  it { is_expected.to have_attributes(:venue       => 'Argyros Forum') }
  it { is_expected.to have_attributes(:pricing     => 'Fixed') }
  it { is_expected.to have_attributes(:url         => 'http://chapman.universitytickets.com/user_pages/event.asp?id=185') }
  it { is_expected.to have_attributes(:quantity    => '200') }
  it { is_expected.to have_attributes(:tickets     => an_instance_of(Array)) }
end