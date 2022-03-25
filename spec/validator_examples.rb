# frozen_string_literal: true

RSpec.shared_examples 'cypher' do |params = {}|
  context "when secret code: 6543 and guess: #{params[:guess]}" do
    let(:result) { Codebreaker::Game.new.encrypt_secret(params[:secret], params[:guess]) }

    specify { expect(result).to eq params[:cypher] }
  end
end
