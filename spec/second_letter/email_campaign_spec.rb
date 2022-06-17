require "spec_helper"
require 'date'

# EmailCampaign — почтовая рассылка.
#
# `#schedule_on` ставит рассылку на отправку в указанное время `date`.
# `#to_plain_text` собирает письмо в текстовом виде.
class EmailCampaign
  DEFAULT_PLAIN_TEXT_SIGNATURE = "\n\n--\n Awesome Mail.app, http://awesomemail.app/".freeze

  attr_reader :subject, :body, :scheduled_on

  def initialize(subject:, body:)
    @subject = subject
    @body = body
  end

  def schedule_on(date)
    @scheduled_on = date
  end

  def to_plain_text
    [subject_field, body_with_signature].join("\n")
  end

  private

  def subject_field
    "Subject: #{subject}"
  end

  def body_with_signature
    [body.strip, DEFAULT_PLAIN_TEXT_SIGNATURE].join
  end
end

RSpec.describe EmailCampaign do
  describe '#call' do
    let(:mailer) {described_class.new(subject: subject, body: body)}
    let(:subject) {'test'}
    let(:body) {'test body'}
    let(:date) { Date.today }
    let(:signature) {[body.strip, EmailCampaign::DEFAULT_PLAIN_TEXT_SIGNATURE].join}
    let(:subject_field) {"Subject: #{subject}"}
    let(:plained_text) {[subject_field, signature].join("\n")}

      it 'schedules date' do
        expect{ mailer.schedule_on(date) }.to change{ mailer.scheduled_on } .to(date)
      end

      it 'makes letter to plain text' do
        #stub_const('DEFAULT_PLAIN_TEXT_SIGNATURE', "\n\n--\n Awesome Mail.app, http://awesomemail.app/".freeze)

        expect(mailer.to_plain_text).to match( plained_text)
      end
  end
end