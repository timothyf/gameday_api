require 'gameday_util'
require 'game'
require 'gameday'

class Team
  
  attr_accessor :abrev, :city, :name
  
  def initialize(abrev)
    @@abrevs = {}
    @@abrevs['ana'] = ['Anaheim','Angels']
    @@abrevs['bos'] = ['Boston','Red Sox']
    @@abrevs['cha'] = ['Chicago','White Sox']
    @@abrevs['chn'] = ['Chicago','Cubs']
    @@abrevs['det'] = ['Detroit','Tigers']
    @@abrevs['ari'] = ['Arizona','Diamondbacks']
    @@abrevs['bal'] = ['Baltimore','Orioles']
    @@abrevs['cle'] = ['Cleveland','Indians']
    @@abrevs['col'] = ['Colorado','Rockies']
    @@abrevs['flo'] = ['Florida','Marlins']
    @@abrevs['cin'] = ['Cincinnati','Reds']
    @@abrevs['atl'] = ['Atlanta','Braves']
    @@abrevs['hou'] = ['Houston','Astros']
    @@abrevs['kca'] = ['Kansas City','Royals']
    @@abrevs['min'] = ['Minnesota','Twins']
    @@abrevs['mil'] = ['Milwaukee','Brewers']
    @@abrevs['nya'] = ['New York','Yankees']
    @@abrevs['nyn'] = ['New York','Mets']
    @@abrevs['oak'] = ['Oakland','As']
    @@abrevs['lan'] = ['Los Angeles','Dodgers']
    @@abrevs['pit'] = ['Pittsburgh','Pirates']
    @@abrevs['phi'] = ['Philadelphi','Phillies']
    @@abrevs['usa'] = ['USA','All-Stars']
    @@abrevs['jpn'] = ['Japan','All-Stars']
    @@abrevs['sln'] = ['St. Louis','Cardinals']
    @@abrevs['sfn'] = ['SanFrancisco','Giants']
    @@abrevs['sea'] = ['Seattle','Mariners']
    @@abrevs['sdn'] = ['San Diego','Padres']
    @@abrevs['tba'] = ['Tampa Bay','Devil Rays']
    @@abrevs['tex'] = ['Texas','Rangers']
    @@abrevs['tor'] = ['Toronto','Blue Jays']
    @@abrevs['was'] = ['Washington','Nationals']
    if (abrev && abrev != '')
      self.abrev = abrev
      self.city = Team.teams[self.abrev][0]
      self.name = Team.teams[self.abrev][1]
    end
  end
  
  
  def self.teams
    @@abrevs
  end
  
  
  # Returns a team's game object for the date passed in.
  def game_for_date(year, month, day)
    api = Gameday.new
    gid = api.find_gid_for_team(year, month, day, self.abrev)
    game = Game.new(gid)
    game
  end

end