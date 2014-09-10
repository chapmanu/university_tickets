require 'time'

module UniversityTickets
  module DateUtils
    def start_of_week(date = Date.today)
      date - date.wday
    end

    def end_of_week(date = Date.today)
      (date - date.wday) + 7
    end

    def start_of_month(date = Date.today)
      date - date.day + 1
    end

    def end_of_month(date = Date.today)
      Date.new(date.year, date.month, -1)
    end

    def start_of_year(date = Date.today)
      Date.new(date.year)
    end

    def end_of_year(date = Date.today)
      Date.new(date.year, -1, -1)
    end

  end
end