# frozen_string_literal: true

RSpec.shared_examples 'cypher' do |params = {}|
  context "when secret code: 6543 and guess: #{params[:guess]}" do
    let(:result) { Codebreaker::Game.new.encrypt_secret(params[:secret], params[:guess]) }

    specify { expect(result).to eq params[:cypher] }
  end
end

RSpec.shared_examples 'not registered game' do |params|
  it "raises GameNotExistError when ##{params}" do
    expect { expected }.to raise_error(Codebreaker::GameNotExistError)
  end
end

RSpec.shared_examples 'registered game' do |params|
  before { registered_game.instance_variable_set(:@secret, '1234') }

  let(:registered_game) { Codebreaker::Game.new.register_game('Game', 'easy') }
  it "has a secret that has #{params[:secret_length]} digits" do
    expect(registered_game.instance_variable_get(:@secret).length).to eq(params[:secret_length])
  end

  it 'has a name' do
    expect(registered_game.name).to eq('Game')
  end

  it "has a diffculty set to #{params[:difficulty]}" do
    expect(registered_game.difficulty).to eq('easy')
  end

  it "diffcilulty is in #{Codebreaker::Game::DIFFICULTY.keys}" do
    expect(Codebreaker::Game::DIFFICULTY.keys).to include(registered_game.difficulty.to_sym)
  end

  it "has #{params[:hints]} hints" do
    expect(registered_game.hints).to eq(params[:hints])
  end

  it "has #{params[:attempts]} attempts" do
    expect(registered_game.attempts).to eq(params[:attempts])
  end
end
