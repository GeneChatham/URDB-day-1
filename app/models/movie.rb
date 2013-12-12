class Movie < ActiveRecord::Base
  has_many :showtimes
  has_many :roles
  has_many :stars, through: :roles
  validates :title, presence: true

  def rotten_finder
    RottenMovie.find(title: title, limit: 1)
  end
  
  def snippet
    description.to_s.truncate 50
  end

  def audience_rating
    if self.rotten_finder != []
      self.rotten_finder.ratings.audience_score
    else
      return nil
    end
  end

  def self.average_rating
    
    # #get all movie scores
    # scores = self.all.collect do |movie|
    #   movie.audience_rating
    # end

    # #add all movie scores together
    # sum = scores.sum
    # #divide by number of movies
    # average = sum/scores.length

    moviecount = 0
    averagetotal = 0

    Movie.all.each do |movie|
      if movie.audience_rating != nil  
        averagetotal += movie.audience_rating
        moviecount += 1
        puts averagetotal            
        puts moviecount
      end
    end
    if moviecount == 0
      return nil
    else
      return (averagetotal / moviecount)
    end
  end

end
