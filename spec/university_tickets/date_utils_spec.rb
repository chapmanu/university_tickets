describe UniversityTickets::DateUtils do
  include UniversityTickets::DateUtils

  describe '#start_of_week' do
    it 'returns first day of the a date\'s week' do
      date = Date.new(1990, 9, 16)
      expect(start_of_week(date))    .to eq(Date.new(1990, 9, 16))
      expect(start_of_week(date + 1)).to eq(Date.new(1990, 9, 16))
      expect(start_of_week(date + 7)).to eq(Date.new(1990, 9, 23))
    end
  end

  describe '#end_of_week' do
    it 'returns last day of the a date\'s week' do
      date = Date.new(1990, 9, 16)
      expect(end_of_week(date))    .to eq(Date.new(1990, 9, 23))
      expect(end_of_week(date + 3)).to eq(Date.new(1990, 9, 23))
      expect(end_of_week(date + 7)).to eq(Date.new(1990, 9, 30))
    end
  end

  describe '#start_of_month' do
    it 'returns first day of the a date\'s month' do
      date = Date.new(1990, 9, 16)
      expect(start_of_month(date))     .to eq(Date.new(1990, 9, 1))
      expect(start_of_month(date + 3)) .to eq(Date.new(1990, 9, 1))
      expect(start_of_month(date + 30)).to eq(Date.new(1990, 10, 1))
    end
  end

  describe '#end_of_month' do
    it 'returns last day of the a date\'s month' do
      date = Date.new(1990, 9, 16)
      expect(end_of_month(date))     .to eq(Date.new(1990, 9, 30))
      expect(end_of_month(date + 3)) .to eq(Date.new(1990, 9, 30))
      expect(end_of_month(date + 30)).to eq(Date.new(1990, 10, 31))
    end
  end

  describe '#start_of_year' do
    it 'returns first day of the a date\'s year' do
      date = Date.new(1990, 9, 16)
      expect(start_of_year(date))     .to eq(Date.new(1990, 1, 1))
      expect(start_of_year(date + 50)) .to eq(Date.new(1990, 1, 1))
      expect(start_of_year(date + 365)).to eq(Date.new(1991, 1, 1))
    end
  end

  describe '#end_of_year' do
    it 'returns last day of the a date\'s year' do
      date = Date.new(1990, 9, 16)
      expect(end_of_year(date))      .to eq(Date.new(1990, 12, 31))
      expect(end_of_year(date + 50)) .to eq(Date.new(1990, 12, 31))
      expect(end_of_year(date + 365)).to eq(Date.new(1991, 12, 31))
    end
  end
end