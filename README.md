This crate uses [ranked choice
voting](https://ballotpedia.org/Ranked-choice_voting_(RCV)) to allow
users to vote on the next [Rust live-coding
stream](https://youtube.com/c/JonGjengset). It is not specific to this
particular voting topic beyond some labels here and there though.

The basic idea is that users rank the candidates (stream ideas)
according to which they would rather watch, and an election is run
before each stream to determine the topic of the stream. Since ranked
choice voting lets users specify multiple preferences, this process can
then be repeated for the next stream, where it will go to each user's
second preferred candidate, etc.

This implementation is *not* written to be secure or efficient. Quite to
the contrary. Users identify with a self-chosen username, and all that
is required to change their ballot in the future (e.g., to add votes for
new stream ideas) is that same username. This means that any user can
change any other user's ballot simply by giving their username. **So
don't use this for anything serious.**

To deploy, run:

```console
$ sqlite3 db/db.sqlite < schema.sql
$ cargo run --release
```

The web interface will now be available on port `8000`.

To add new candidates for voting, use `sqlite3 db/db.sqlite` and issue
insert statements of the following form:

```sql
INSERT INTO items (title, body) VALUES ("My Great Idea", "Here's why it's great");
```

To mark a candidate as no longer available (e.g., because a stream has
already been produced for it), just mark it as done with:

```sql
UPDATE items SET done = true WHERE id = ?;
```

Where `?` is the ID of the candidate, which you can find with

```sql
SELECT id, title FROM items WHERE done = false;
```
