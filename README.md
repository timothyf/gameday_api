# Abanico

Forked from timothyf: https://github.com/timothyf/gameday_api

This is a gem that I hope will make the Gameday API easy. My next priority is abstracting most of the methods into class methods so that the user doesn't have to instantiate an object in order to use the API. Other known issues:
* The class methods should return JSON as much as possible
* The Game ID inputs right now are not human readable.
* The Player lookup currently must take a game as an input, which is incredibly inconvenient. 
* The Players class needs all methods as class methods.
* More extensive documentation is needed
* Every reference to MySQL needs to be burned with fire.

## Installation
-------
Add this line to your application's Gemfile:

    gem 'gameday_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gameday_api

## Usage
-------

#### GamedayApi::Game
```ruby
games = GamedayApi::Game.find_by_date('2011', '10', '01')
games.each do |game| 
    puts game.print_linescore
    puts
end
#=> Prints the linescore for all games played on October 01, 2011

game = GamedayApi::Game.new("2011_10_27_texmlb_slnmlb_1")  #=> Creates a new game based on a game id
game.get_lineups  #=> Returns an array of batters for home and an array of batters for away. 
```

#### GamedayApi::Team
```ruby
royals = GamedayApi::Team.new('kca')  #=> Returns a Team object of the Kansas City Royals
royals.all_games(2014) #=> Returns an array of all games in the specified season
royals.get_closers_unique(2014) #=> Returns an array of all pitchers who closed at least one game during the specified season.

cardinals = GamedayApi::Team.new('sln') #=> Returns a Team object of the St. Louis Cardinals
team.get_start_pitcher_appearances_by_year('2011') #=> Returns an array of all pitching starts for the specified season.
```

#### GamedayApi::Scoreboard
```ruby
GamedayApi::Scoreboard.load_for_date(2015, 03, 27) #=> Loads a scoreboard xml file for the specified date.
```

#### GamedayApi::Players
```ruby
players = GamedayApi::Players.new #=> Creates a new instance of the players class
players = GamedayApi::Players.new(2015_03_27_bosmlb_atlmlb_1) #=> Returns an XML of the player an umpire rosters for the specified game id. 
```

#### GamedayApi::Player
```ruby
player = GamedayApi::Player.new
player.load_from_id('2015_03_27_bosmlb_atlmlb_1', 605141) #=> Initialized a player object from the xml file on GameDay
player.get_mugshot(medium) #=> returns a medium-sized player mugshot
```

#### GamedayApi::BoxScore
```ruby
box_score = GamedayApi::BoxScore.new
box_score.load_from_id('2015_03_27_bosmlb_atlmlb_1') #=> Returns the box score for the specified game id
box_score.get_leadoff_hitters #=> Returns the leadoff hitters for that game
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request



