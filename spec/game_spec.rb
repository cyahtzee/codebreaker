# frozen_string_literal: true

module Codebreaker
  RSpec.describe Game do
    let(:subject) { described_class.new.register_game('John', 'easy') }

    describe 'Game properties' do
      it 'has a secret' do
        expect(subject.generate_secret).not_to be nil
      end
      it 'has a secret with 4 digits' do
        expect(subject.generate_secret.length).to eq 4
      end
      it 'has a secret with numbers from 1 to 6' do
        expect(subject.generate_secret).to match(/[1-6]{4}/)
      end
      it 'has a instance variable @secret' do
        expect(subject.instance_variable_get(:@secret)).not_to be nil
      end
      it 'has instance variable @secret that is not visible to outside' do
        expect { subject.secret }.to raise_error(NoMethodError)
      end
    end

    describe '#register_game' do
      it 'returns a new instance of Game' do
        expect(subject).to be_instance_of(Game)
      end
      it 'returns a new instance of Game with name' do
        expect(subject.name).to eq 'John'
      end
      it 'returns a new instance of Game with difficulty' do
        expect(subject.difficulty).to eq 'easy'
      end
      it 'returns a new instance of Game with attempts' do
        expect(subject.attempts).to eq Game::DIFFICULTY[:easy][:attempts]
      end
      it 'returns a new instance of Game with hints' do
        expect(subject.hints).to eq Game::DIFFICULTY[:easy][:hints]
      end
    end

    describe '#make_guess' do
      it 'returns an encrypted string according to the secret' do
        secret = subject.instance_variable_get(:@secret)
        result = subject.encrypt_secret(secret, '1234')
        expect(subject.make_guess('1234')).to eq result
      end
    end

    describe '#give_hint' do
      let(:with_hints) do
        4.times { subject.give_hint }
        subject
      end

      it 'returns a hint that is a single digit from the secret' do
        expect(subject.give_hint).to match(/[1-6]{1}/)
      end
      it 'return a hint unless there are no more hints left' do
        expect(with_hints.give_hint).not_to receive(:give_hint)
      end
    end
  end
end
