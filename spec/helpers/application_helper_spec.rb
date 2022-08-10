require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#format_price' do
    it 'formats price' do
      expect(helper.format_price(100)).to eq('$1.0')
    end
  end

  describe '#format_date' do
    it 'formats date' do
      date = Time.now

      expect(format_date(date)).to eq(date.strftime("%A, %B %d, %Y"))
    end
  end

  describe '#convert_and_format_date' do
    it 'converts date' do
      date = Date.today
      expect(convert_and_format_date(date)).to eq(date.strftime("%A, %B %d, %Y"))

      date = '2018-01-01'
      expect(convert_and_format_date(date)).to eq(Date.strptime(date, '%Y-%m-%d').strftime("%A, %B %d, %Y"))

      date = 99
      expect(convert_and_format_date(date)).to eq('N/A')
    end

    it 'converts date string' do
      date = '2020-01-01'
      expect(convert_date(date)).to eq(Date.strptime(date, '%Y-%m-%d'))
    end

    it 'returns N/A if input is not a date or string' do
      expect(convert_and_format_date(nil)).to eq('N/A')
    end
  end
end