class Movie < ActiveRecord::Base
  has_many :showtimes
  has_many :roles
  has_many :stars, through: :roles

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
      return "We are DEEPLY sorry that the movie was not found on Rotten Tomatoes."
    end
  end

end
