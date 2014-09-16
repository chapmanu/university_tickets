describe UniversityTickets::Client do
  let(:client) { UniversityTickets::Client.new(:base_url => 'http://mock.me') }

  describe '#build_date_range' do
    let(:client) { UniversityTickets::Client.new(:base_url => 'http://mock.me') }
    let(:today) { Date.today }

    it 'accepts param :today' do
      expect(client.send(:build_date_range_from_symbol, :today)).to eq({:start => today.to_s, :end => (today+1).to_s })
    end

    it 'accepts param :tomorrow' do
      expect(client.send(:build_date_range_from_symbol, :tomorrow)).to eq({:start => (today+1).to_s, :end => (today+2).to_s })
    end

    it 'accepts param :this_week' do
      expect(client.send(:build_date_range_from_symbol, :this_week)).to eq({:start => (today - today.wday).to_s, :end => (today - today.wday + 7).to_s })
    end

    it 'accepts param :this_month' do
      expect(client.send(:build_date_range_from_symbol, :this_month)).to eq({:start => (today - today.day + 1).to_s, :end => Date.new(today.year, today.month, -1).to_s })
    end

    it 'accepts param :this_year' do
      expect(client.send(:build_date_range_from_symbol, :this_year)).to eq({:start => Date.new(today.year, 1, 1).to_s, :end => Date.new(today.year, 12, 31).to_s })
    end
  end

  describe '#events' do
    it 'returns an empty array when there are no results' do
      stub_events_no_data
      events = client.events(on: Date.new(2000,1,1))
      expect(events).to eq([])
    end

    it 'returns an empty array when there is weird data' do
      stub_events_with_weird_data
      events = client.events(on: Date.new(2000, 1,1))
      expect(events).to be_nil
    end

    it 'returns instantiated event objects when good json' do
      stub_events_with_good_data
      events = client.events(start: Date.new(2000,1,1), end: Date.new(2001,1,1))
      expect(events).to include(UniversityTickets::Event)
      expect(events.length).to eq(193)
    end
  end

  describe '#event' do
    it 'returns an event when successful' do
      stub_single_event_success
      event = client.event(501)
      expect(event).to be_a(UniversityTickets::Event)
      expect(event).to have_attributes({id: '501', title: 'led zeppelin', pricing: 'Fixed'})
      expect(event.tickets.length).to eq(2)
    end

    it 'returns an nil when no data' do
      stub_single_event_no_data
      event = client.event(502)
      expect(event).to be_nil
    end

    it 'returns nil when weird data' do
      stub_single_event_weird_data
      event = client.event(503)
      expect(event).to be_nil
    end

    it 'returns nil when there is an empty array' do
      stub_single_event_empty_array
      event = client.event(504)
      expect(event).to be_nil
    end
  end
end