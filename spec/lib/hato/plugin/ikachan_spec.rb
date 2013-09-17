require_relative '../../../spec_helper'
require 'hato/config'

describe Hato::Plugin::Ikachan do
  describe '#notify' do
    context 'arguments' do
      context 'channel' do
        context 'when channel is passed as a string' do
          subject {
            described_class.new(
              Hato::Config::Plugin.new('Ikachan') {
                scheme  'example.com'
                channel 'test'
              }
            )
          }
          before {
            allow(subject).to receive(:send_message)
          }

          it {
            expect(subject).to receive(:send_message).exactly(2).times
            subject.notify(tag: 'test', message: 'test')
          }
        end

        context 'when channel is passed as an array' do
          subject {
            described_class.new(
              Hato::Config::Plugin.new('Ikachan') {
                scheme  'example.com'
                channel %w[test1 test2]
              }
            )
          }
          before {
            allow(subject).to receive(:send_message)
          }

          it {
            expect(subject).to receive(:send_message).exactly(4).times
            subject.notify(tag: 'test', message: 'test')
          }
        end
      end
    end

    context 'success' do
      subject {
        described_class.new(
          Hato::Config::Plugin.new('Ikachan') {
            scheme  'example.com'
            channel 'test'
          }
        )
      }
      before {
        allow(subject).to receive(:send_request).and_return(
          Net::HTTPSuccess.new('1.1', '200', 'success')
        )
      }

      it {
        expect {
          subject.notify(tag: 'test', message: 'test')
        }.not_to raise_error
      }
    end

    context 'failure' do
      context 'network error' do
        subject {
          described_class.new(
            Hato::Config::Plugin.new('Ikachan') {
              scheme  'example.com'
              channel 'test'
            }
          )
        }
        before {
          allow(subject).to receive(:send_request).and_raise(
            Timeout::Error.new('timeout')
          )
        }

        it {
          expect {
            subject.notify(tag: 'test', message: 'test')
          }.to raise_error(Timeout::Error)
        }
      end

      context 'http error' do
        subject {
          described_class.new(
            Hato::Config::Plugin.new('Ikachan') {
              scheme  'example.com'
              channel 'text'
            }
          )
        }
        before {
          allow(subject).to receive(:send_request).and_return(
            Net::HTTPServerError.new('1.1', '500', 'forbidden')
          )
        }

        it {
          expect {
            subject.notify(tag: 'test', message: 'test')
          }.to raise_error(Net::HTTPFatalError)
        }
      end
    end
  end
end

