describe UniversityTickets::Client do
  describe '#build_date_range' do
    let(:client) { UniversityTickets::Client.new }
    let(:today) { Date.today }

    it 'accepts param :today' do
      expect(client.build_date_range_from_symbol(:today)).to eq({:start => today.to_s, :end => (today+1).to_s })
    end

    it 'accepts param :tomorrow' do
      expect(client.build_date_range_from_symbol(:tomorrow)).to eq({:start => (today+1).to_s, :end => (today+2).to_s })
    end

    it 'accepts param :this_week' do
      expect(client.build_date_range_from_symbol(:this_week)).to eq({:start => (today - today.wday).to_s, :end => (today - today.wday + 7).to_s })
    end

    it 'accepts param :this_month' do
      expect(client.build_date_range_from_symbol(:this_month)).to eq({:start => (today - today.day + 1).to_s, :end => Date.new(today.year, today.month, -1).to_s })
    end

    it 'accepts param :this_year' do
      expect(client.build_date_range_from_symbol(:this_year)).to eq({:start => Date.new(today.year, 1, 1).to_s, :end => Date.new(today.year, 12, 31).to_s })
    end
  end
end