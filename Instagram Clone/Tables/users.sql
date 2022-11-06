-- creation of users:

create table users
(
    id int primary key auto_increment,
    username varchar(255) unique not null,
    created_at timestamp default now()
);