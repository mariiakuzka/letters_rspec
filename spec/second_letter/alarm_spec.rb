require "spec_helper"


# Alarm — будильник, установленный на определенное время (`at`).
#
# `#to_human` возвращает время в человеческом формате: 22:30, 6:50.
# `#snooze_for` откладывает будильник, дает вздремнуть еще `minutes` минут.
class Alarm
  attr_accessor :at

  def initialize(at:)
    @at = at
  end

  def to_human
    at.strftime("%k:%M").strip
  end

  def snooze_for(minutes)
    self.at = at + minutes * 60
  end
end

RSpec.describe Alarm do
  describe '#call' do

  let(:alarm) {described_class.new(at: at)}
  let(:at) {}
  #let(:minutes) {20}

    it '#to_human' do
      expect(alarm.to_human).to eq("10:51")
    end

    it '#snooze_for' do

      expect{ alarm.snooze_for(20) }.to change{ alarm.at}.to eq(at + 20 * 60)
    end
  end
end