#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo "$($PSQL "TRUNCATE TABLE games, teams")"

# while loop to pipeline data rows from games.csv
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
if [[ $YEAR != "year" ]]
then
  # 1. inserting unique teams into teams' table
  
  #1.1 checking if the winner team already exists in the DB
  WINNER_TEAM="$($PSQL "SELECT * FROM teams WHERE name='$WINNER'")"
  # if the winner team does not exist within the DB
  if [[ -z $WINNER_TEAM ]]
  then
  # then insert the winner team within the db
    INSERT_WINNER="$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")"
    # if insertion is successful, print a success message
    if [[ $INSERT_WINNER == "INSERT 0 1" ]]
    then
      echo Inserted $WINNER successfully!
    else 
      echo failed to insert $WINNER!
    fi
  else
    echo $WINNER already exists
  fi

  #1.2 checking if the opponent team already exists in the DB
    OPPONENT_TEAM="$($PSQL "SELECT * FROM teams WHERE name='$OPPONENT'")"
  # if the opponent team does not exist within the DB
  if [[ -z $OPPONENT_TEAM ]]
  then
  # then insert the opponent team within the db
    INSERT_OPPONENT="$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")"
    # if insertion is sucessful, print a success message
    if [[ $INSERT_OPPONENT == "INSERT 0 1" ]]
    then
      echo Inserted $OPPONENT successfully!
    else
      echo Failed to insert $OPPONENT!
    fi
  else
    echo $OPPONENT already exists
  fi

  #2 Inserting a full row of data in games' table

  #2.1 getting the team_id for both teams in the targeted game
  WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
  OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
  
  #2.2 insert the data in the games table
  INSERT_GAME="$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")"
  #2.3 checking data insertion
  if [[ $INSERT_GAME == "INSERT 0 1" ]]
  then
    echo Game data inserted Successfully!
  else
    echo Failed to insert game data!
  fi
fi
done