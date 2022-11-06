-- creation of (hash)tags:

create table tags
(
    id int primary key auto_increment,
    tag_name varchar(255) unique not null,
    created_at timestamp default now()
);