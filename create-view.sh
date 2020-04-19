#!/bin/bash
sqlite3 jsk.db "create view jsk_fellows as
    select
        users.id,
        users.name,
        users.description,
        users.location,
        users.url,
        'https://twitter.com/' || users.screen_name as twitter,
        group_concat(lists.slug) as fellowship,
        users.followers_count,
        users.created_at,
        users.verified,
        users.screen_name
    from users
        join list_members
            on list_members.user = users.id
        join lists
            on list_members.list = lists.id
    where
        lists.slug like 'jsk-fellows%'
        and lists.slug not like '%projects'
    group by users.id;"
sqlite3 jsk.db .schema