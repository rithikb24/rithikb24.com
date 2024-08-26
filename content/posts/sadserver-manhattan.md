+++
title = "Scenario: Manhattan: can't write data into database"
date = "2024-06-27"
+++

## Introduction

[SadServers Manhattan Scenario](https://sadservers.com/scenario/manhattan)
    From the description we know -

    postgres database running on 5432 port.

    config file at /etc/postgresql/14/main/postgresql.conf

    writes to disk at data_directory as mentioned in config file

## Objective

To be able to insert a row in the postgres database

## Approach

My initial thought was to just to run the command given for inserting a row and see what we get. My thought being whatever error output we get would be the starting point of debugging.
    psql: error: connection to server on socket "/var/run/postgresql/.s.PGSQL.5432" failed: No such file or directory Is the server running locally and accepting connections on that socket?

so we know there's nothing running at 5432 port.

We will need to check the status of postgres database.

```bash
systemctl status postgresql
```

The service is active, but we know something's wrong so lets check more logs.
/var/log generally stores logs for all kinds of services on linux

Found postgresql folder.
a quick look at the logs file reveals the problem.

    2023-11-20 18:14:21.812 UTC [660] FATAL: could not create lock file "postmaster.pid": No space left on device pg_ctl: could not start server Examine the log output.

to examine disk space on this system

```bash
df -hT
```

```text
/dev/nvme0n1 xfs 8.0G 8.0G 28K 100% /opt/pgdata
```

From the config file at /etc/postgresql/14/main/postgresql.conf. We know that the db is trying to store data in /opt/pgdata/main.
So, We will need to clear up some space.

this command reveals space taken by individual file in a directory.

```bash
du -sh *
```

we will need to purge files with ".bk"

```bash
sudo rm *.bk
```

```bash
sudo systemctl restart postgresql
```

we are done!
