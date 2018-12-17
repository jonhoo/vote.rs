DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    username TEXT NOT NULL UNIQUE
);
CREATE UNIQUE INDEX uname ON users(username);

DROP TABLE IF EXISTS items;
CREATE TABLE items (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    done BOOL NOT NULL DEFAULT false
);

DROP TABLE IF EXISTS votes;
CREATE TABLE votes (
    user_id INTEGER NOT NULL,
    item_id INTEGER NOT NULL,
    ordinal INTEGER NOT NULL,

    FOREIGN KEY(user_id) REFERENCES users(id)
    FOREIGN KEY(item_id) REFERENCES items(id)
);
CREATE UNIQUE INDEX no_dup_votes ON votes(user_id, item_id);
CREATE INDEX ballot ON votes(user_id ASC, ordinal ASC);
