require 'spec_helper'

describe Movie do
  let(:movie) { Movie.new }
  let(:rotten_finder_return) { OpenStruct.new(ratings: OpenStruct.new(audience_score: 84)) }
  
  describe '#snippet' do
    context "when description is less than or equal to 50 characters" do
      it "returns the full description" do
        allow(movie).to receive(:description).and_return("Once-general, now-gladiator seeks revenge in arena")
        expect(movie.snippet).to eq("Once-general, now-gladiator seeks revenge in arena")      
      end
    end

    context "when description is greater than 50 characters" do
      it "returns the first 47 characters and appends '...'" do
        allow(movie).to receive(:description).and_return("When a Roman general is betrayed and his family murdered by an emperor's corrupt son, he comes to Rome as a gladiator to seek revenge.")

        expect(movie.snippet).to eq('When a Roman general is betrayed and his family...')
      end
    end
    
    context "when a description is nil" do
      it "returns an empty string" do
        allow(movie).to receive(:description).and_return(nil)

        expect(movie.snippet).to eq('')
      end
    end
  end

  describe '#audience_rating' do
    context "when Movie is found on Rotten Tomatoes" do
      it "returns the audience score for the Movie" do
        allow(movie).to receive(:rotten_finder).and_return(rotten_finder_return)

        expect(movie.audience_rating).to eq(84)
      end
    end
  end

end
