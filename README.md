# freeCodeCamp Relational Database SQL Course Solutions

## Build a Celestial Bodies Database

   - universal.sql

## World Cup Database

### The submission requirements
- Creating `worldcup`, and two tables `games`, `teams` DB within a terminal session using psql
- Pipeline the contents of `games.csv` into respective tables, while avoiding redundant insertions, and getting foreign keys for teams, which is implemented in `insert_data.sh`
- After populating the database, retrieve data according to specs defined within the comments in `queries.sh` using PostgresSQL queries

### Contents of the Repo
- the resulting DB contents dumped in `worldcup.sql` using `pg_dump` CLI utility
- bash scripts used for population and insertion `insert_data.sh` and `queries.sh`
