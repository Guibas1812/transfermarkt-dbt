# Transfermarkt dbt Project

![dbt](https://img.shields.io/badge/dbt-FF694B?style=flat&logo=dbt&logoColor=white)
![Snowflake](https://img.shields.io/badge/Snowflake-29B5E8?style=flat&logo=snowflake&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=flat&logo=postgresql&logoColor=white)

A dbt project built on top of the [Transfermarkt dataset from Kaggle](https://www.kaggle.com/datasets/davidcariboo/player-scores), loaded into Snowflake. The goal is to model raw football data into clean, analysis-ready tables following analytics engineering best practices.

---

## Project Structure

The project follows the standard dbt layered architecture:

```
📁 models/
├── 📁 staging/
│   └── 📁 transfermarkt/
│       ├── stg_transfermarkt__appearances.sql
│       ├── stg_transfermarkt__club_games.sql
│       ├── stg_transfermarkt__clubs.sql
│       ├── stg_transfermarkt__competitions.sql
│       ├── stg_transfermarkt__game_events.sql
│       ├── stg_transfermarkt__game_lineups.sql
│       ├── stg_transfermarkt__games.sql
│       ├── stg_transfermarkt__player_valuations.sql
│       ├── stg_transfermarkt__players.sql
│       └── stg_transfermarkt__transfers.sql
├── 📁 intermediate/
│   └── 📁 club_analysis/
│       ├── int_clubs_attendance_summary.sql
│       ├── int_clubs_enriched.sql
│       ├── int_clubs_transfer_info.sql
│       ├── int_games_info.sql
│       ├── int_league_games_only.sql
│       └── int_player_match_stats.sql
└── 📁 marts/
    └── 📁 club_analysis/
        ├── dim_clubs.sql
        ├── dim_competitions.sql
        ├── dim_players.sql
        ├── fct_clubs_performance.sql
        ├── fct_player_match.sql
        ├── fct_player_season.sql
        └── fct_players_transfers.sql

📁 tests/
├── assert_appearances_have_valid_player.sql
├── assert_attendance_not_exceed_capacity.sql
├── assert_net_transfer_balance_calculation.sql
├── assert_player_age_reasonable.sql
└── assert_transfer_fee_non_negative.sql
```

---

## Layers

- **Staging** — one model per source table, renaming and light cleaning only, materialized as views
- **Intermediate** — business logic and joins, not exposed to end users, materialized as views
- **Marts** — final dimensional and fact tables, materialized as tables for query performance

---

## Marts Overview

| Model | Type | Description |
|---|---|---|
| `dim_clubs` | Dimension | Club attributes with competition and country data |
| `dim_players` | Dimension | Player profiles with calculated age |
| `dim_competitions` | Dimension | Competition reference table |
| `fct_clubs_performance` | Fact | Transfer activity and attendance aggregated per club |
| `fct_players_transfers` | Fact | Transfer history at player level |
| `fct_player_match` | Fact | Player stats at match level |
| `fct_player_season` | Fact | Player stats by season including goals/assists/minutes per 90 |

---

## Tech Stack

| Tool | Purpose |
|---|---|
| Snowflake | Data warehouse |
| dbt Cloud | Transformation and modeling |
| Kaggle (Transfermarkt) | Source data |
