class Mixtape < ActiveRecord::Base


belongs_to :user
has_and_belongs_to_many :tracks
has_many :likes


  def match_rate(match_mixtape)
    me = self.tracks
    you = match_mixtape
    me_song, me_artist, me_genre = mix_values(me, 'id') , mix_values(me, 'artist'), mix_values(me, 'genre')
    you_song, you_artist, you_genre = mix_values(you, 'id') , mix_values(you, 'artist'), mix_values(you, 'genre')
    result = (((me_genre & you_genre).count * 2) + 
              ((me_song & you_song).count * 3) + 
              ((me_artist & you_artist).count * 1))
  end

  def mix_values(mixtape, attribute) 
    mixtape.map{ |song| song[attribute.to_sym] }
  end




end
