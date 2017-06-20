-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

DROP DATABASE IF EXISTS tournament;
CREATE DATABASE tournament;
\c tournament

DROP VIEW IF EXISTS standings;
DROP VIEW IF EXISTS match_count;
DROP VIEW IF EXISTS win_count;
DROP TABLE IF EXISTS matches;
DROP TABLE IF EXISTS players;

CREATE TABLE players (player_id SERIAL PRIMARY KEY,
                      name TEXT);

CREATE TABLE matches (match_id SERIAL PRIMARY KEY,
                      winner INT REFERENCES players (player_id) ON DELETE CASCADE,
                      loser INT REFERENCES players (player_id) ON DELETE CASCADE
                      CHECK (winner <> loser));

-- Keeps track of number of wins per player
CREATE VIEW win_count AS
  SELECT player_id, name, count(matches.winner) AS wins
    FROM players LEFT JOIN matches
      ON players.player_id = matches.winner
    GROUP BY players.player_id;

-- Keeps track of number of matches per player
CREATE VIEW match_count AS
  SELECT player_id, name, count(matches.match_id) AS matches
    FROM players LEFT JOIN matches
    ON (players.player_id = matches.winner
    OR players.player_id = matches.loser)
    GROUP BY players.player_id;

-- Displays number of wins and matches per player ranked by total number of wins
CREATE VIEW standings AS
  SELECT win_count.player_id, win_count.name, win_count.wins, match_count.matches
    FROM win_count JOIN match_count
      ON win_count.player_id = match_count.player_id
    ORDER BY win_count.wins DESC;
