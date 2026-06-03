# Transfermarkt dbt Project

A dbt project built on top of the [Transfermarkt dataset from Kaggle](https://www.kaggle.com/datasets/davidcariboo/player-scores), loaded into Snowflake. The goal is to model raw football data into clean, analysis-ready tables following analytics engineering best practices.

## Project Structure

The project follows the standard dbt layered architecture:

- **Staging** — one model per source table, renaming and light cleaning only
- **Intermediate** — business logic and joins, not exposed to end users
- **Marts** — final dimensional and fact tables, materialized as tables for query performance

## Models

### Staging
10 staging models covering clubs, players, games, appearances, transfers, game events, lineups, competitions, club games, and player valuations.

### Intermediate
- `int_clubs_enriched` — clubs joined with competition/country data
- `int_clubs_transfer_info` — transfer income and spend per club per season
- `int_clubs_attendance_summary` — home game attendance aggregated at club level
- `int_games_info` — games with competition type context
- `int_league_games_only` — filtered to league games only
- `int_player_match_stats` — player appearance stats joined with game context

### Marts
- `dim_clubs` — club dimension with competition and country attributes
- `dim_players` — player dimension with calculated age
- `dim_competitions` — competition reference table
- `fct_clubs_performance` — one row per club, aggregating transfer activity and attendance across all seasons
- `fct_players_transfers` — transfer history at player level
- `fct_player_match` — player stats at match level
- `fct_player_season` — player stats aggregated by season, including goals/assists/minutes per 90

## Tech Stack
- **Source data**: Kaggle (Transfermarkt)
- **Data warehouse**: Snowflake
- **Transformation**: dbt Cloud
