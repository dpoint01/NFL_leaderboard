require 'sinatra'
require 'csv'
require 'redis'

def get_connection
  if ENV.has_key?("REDISCLOUD_URL")
    Redis.new(url: ENV["REDISCLOUD_URL"])
  else
    Redis.new
  end
end

#------------------------METHODS----------------------#
#                                                     #
#                                                     #
#                                                     #
#-----------------------------------------------------#

def read_csv(csv)

  results = []

  CSV.foreach(csv, headers: true, header_converters: :symbol) do |row|
    results  << row
  end

  return results

end


def calc_wins(games,team)

  win_count_away = 0
  win_count_home = 0
  total_wins = 0

  games.each do |game|
    if(team == game[:home_team])
      if(game[:home_score].to_i > game[:away_score].to_i)
        win_count_home += 1
      end
    elsif(team == game[:away_team])
      if(game[:away_score].to_i > game[:home_score].to_i)
        win_count_away += 1
      end
    end
  end

  total_wins = win_count_away + win_count_home

end

def calc_losses(games, team)

  loss_count_away = 0
  loss_count_home = 0
  total_losses = 0

  games.each do |game|
    if(team == game[:home_team])
      if(game[:home_score].to_i < game[:away_score].to_i)
        loss_count_home += 1
      end
    elsif(team == game[:away_team])
      if(game[:away_score].to_i < game[:home_score].to_i)
        loss_count_away += 1
      end
    end
  end

  total_losses = loss_count_away + loss_count_home

end

def calc_num_games(games, team)
  calc_wins(games,team) + calc_losses(games,team)
end

#-------------------------MAIN------------------------#
#                                                     #
#                                                     #
#                                                     #
#-----------------------------------------------------#

games = read_csv('games.csv')

#--------all of the wins-----#
pat_wins = calc_wins(games, "Patriots")
bro_wins = calc_wins(games, "Broncos")
ste_wins = calc_wins(games, "Steelers")
col_wins = calc_wins(games, "Colts")

#-------all of the losses----#
pat_losses = calc_losses(games, "Patriots")
bro_losses = calc_losses(games, "Broncos")
ste_losses = calc_losses(games, "Steelers")
col_losses = calc_losses(games, "Colts")

#---number of games played---#
pat_games = calc_num_games(games, "Patriots")
bro_games = calc_num_games(games, "Broncos")
ste_games = calc_num_games(games, "Steelers")
col_games = calc_num_games(games, "Colts")




#---------------------HOME--------------------#
get '/' do
  erb :home
end

#------------------LEADERBOARD----------------#
get '/leaderboard' do
  @all_games = games

  #--------all of the wins-----#
  @pat_wins = pat_wins
  @bro_wins = bro_wins
  @ste_wins = ste_wins
  @col_wins = col_wins

  #-------all of the losses----#
  @pat_losses = pat_losses
  @bro_losses = bro_losses
  @ste_losses = ste_losses
  @col_losses = col_losses

  #---number of games played---#
  @pat_games = pat_games
  @bro_games = bro_games
  @ste_games = ste_games
  @col_games = col_games

  erb :leaderboard

end

#-------------------TEAM PAGE----------------#
get '/teams/:home_team' || '/teams/:away_team' do

  @team = params[:home_team] || params[:away_team]

  @all_games = games

  #--------all of the wins-----#
  @pat_wins = pat_wins
  @bro_wins = bro_wins
  @ste_wins = ste_wins
  @col_wins = col_wins

  #-------all of the losses----#
  @pat_losses = pat_losses
  @bro_losses = bro_losses
  @ste_losses = ste_losses
  @col_losses = col_losses

  #---number of games played---#
  @pat_games = pat_games
  @bro_games = bro_games
  @ste_games = ste_games
  @col_games = col_games

  erb :show
end
