-- creation of photo_(hash)tags:

create table photo_tags
(
    photo_id int not null,
    tag_id int not null,
    primary key(photo_id, tag_id),
    foreign key(photo_id) references photos(id),
    foreign key(tag_id) references tags(id)
);