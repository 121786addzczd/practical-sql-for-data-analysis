-- users
COPY users FROM '/tmp/data_set/users.csv'
WITH CSV HEADER
;

-- subscriptions
COPY subscriptions FROM '/tmp/data_set/subscriptions.csv'
WITH CSV HEADER
;

-- user_subscriptions
COPY user_subscriptions FROM '/tmp/data_set/user_subscriptions.csv'
WITH CSV HEADER
;

-- billing_periods
COPY billing_periods FROM '/tmp/data_set/billing_periods.csv'
WITH CSV HEADER
;

-- contents
COPY contents FROM '/tmp/data_set/contents.csv'
WITH CSV HEADER
;

-- user_contents
COPY user_contents FROM '/tmp/data_set/user_contents.csv'
WITH CSV HEADER
;
