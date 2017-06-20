1. Open GitBash window
2. Navigate to vagrant folder in cmd window
3. Type "vagrant up"
4. Type "vagrant ssh"
5. Type "cd /vagrant"

1. Navigate to tournament folder. Type "psql tournament" to connect psql to tournament database
2. Use the command \i tournament.sql to create tables and views
3. Ignore first 5 errors that mention views/tables do not exist as code is
   attempting to drop tables that do not exist
4. Exit psql by hitting CRTL+D
5. Run test script (e.g. python tournament_test.py)
