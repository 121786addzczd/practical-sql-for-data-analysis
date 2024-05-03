#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username brain --dbname analysis_postgres_db <<-EOSQL
        -- users
        DROP TABLE IF EXISTS users;
        CREATE TABLE users (
          id          SERIAL PRIMARY KEY,
          name        VARCHAR(100) NOT NULL,
          level       VARCHAR(50) NOT NULL,
          goal        TEXT,
          created_at  TIMESTAMP NOT NULL
        );

        -- subscriptions
        DROP TABLE IF EXISTS subscriptions;
        CREATE TABLE subscriptions (
          id           SERIAL PRIMARY KEY,
          plan_name    VARCHAR(100) NOT NULL,
          monthly_fee  INTEGER NOT NULL
        );

        -- user_subscriptions
        DROP TABLE IF EXISTS user_subscriptions;
        CREATE TABLE user_subscriptions (
          id               SERIAL PRIMARY KEY,
          user_id          INT NOT NULL,
          subscription_id  INT NOT NULL,
          start_date       DATE NOT NULL,
          end_date         DATE,
          status           VARCHAR(50) NOT NULL,
          created_at       TIMESTAMP NOT NULL,
          FOREIGN KEY (user_id) REFERENCES users(id),
          FOREIGN KEY (subscription_id) REFERENCES subscriptions(id)
        );

        -- billing_periods
        DROP TABLE IF EXISTS billing_periods;
        CREATE TABLE billing_periods (
          id                    SERIAL PRIMARY KEY,
          user_subscription_id  INT NOT NULL,
          start_date            DATE NOT NULL,
          end_date              DATE NOT NULL,
          amount                INTEGER NOT NULL,
          status                VARCHAR(50) NOT NULL,
          FOREIGN KEY (user_subscription_id) REFERENCES user_subscriptions(id)
        );

        -- contents
        DROP TABLE IF EXISTS contents;
        CREATE TABLE contents (
          id            SERIAL PRIMARY KEY,
          title         VARCHAR(255) NOT NULL,
          content_type  VARCHAR(50) NOT NULL
        );

        -- user_contents
        DROP TABLE IF EXISTS user_contents;
        CREATE TABLE user_contents (
          id         SERIAL PRIMARY KEY,
          user_id    INT NOT NULL,
          content_id INT NOT NULL,
          completed  BOOLEAN NOT NULL,
          FOREIGN KEY (user_id) REFERENCES users(id),
          FOREIGN KEY (content_id) REFERENCES contents(id)
        );
EOSQL
