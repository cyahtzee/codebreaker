# frozen_string_literal: true

RSpec.shared_context 'codebreaker' do
  before { registered_game.instance_variable_set(:@secret, secret) }

  let(:registered_game) { Codebreaker::Game.new.register_game(name, difficulty) }
  let(:difficulty) { 'easy' }
  let(:name) { 'Game' }
  let(:secret) { '1234' }
  let(:guess) { '1234' }
  let(:expected) { '++++' }
  let(:invalid_game) { described_class.new }
  let(:hints) do
    allow(registered_game).to receive(:instance_variable_get).with(:@available_hints).and_return(secret.chars)
    registered_game.instance_variable_get(:@available_hints)
  end
end
