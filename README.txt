NFL_leaderboard
===============

Second Systems Check

This second system check was great practice. I was able to do all the core/non-core requirements.

For my implementation, I decided to hard code a CSV file from the data that was provided on Apollo. I then
read in the CSV file and calculated each teams victories, losses and number of games played in order 
to pass on the relavant info to the different files.

I was able to dynamically create my show.erb file for each team's specific info. 
The only thing I wasn't able to do was to create a function that would populate my leaderboard table. 
I had a hard time finding a way to dynamically create and sort my table without entering the info in myself.
I tried several time but I wasn't able to get the final layout/results I wanted.

In my server.rb file I do the same variable assignments twic for get '/leaderboard' and 
get '/teams/:team_name' since I needed the same global variable for both erb files.

Note: I also played around with HTML and CSS to add some extra functionality 
(Home button which changes when you hover over it / different links)

