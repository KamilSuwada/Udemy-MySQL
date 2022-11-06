-- QUESTION 1:
-- Find the 5 oldest users?

select * from users
order by users.created_at asc
limit 5;



-- QUESTION 2:
-- What day of the week do most of the users register on?

select
    dayname(users.created_at) as weekdays,
    count(*) as number_of_registrations
from users
group by weekdays
order by number_of_registrations desc;



-- QUESTION 3:
-- Find the users who have never posted a photo?

select
    username as never_posted
from users
left join photos
    on users.id = photos.user_id
where photos.id is null;



-- QUESTION 4:
-- Who has the most likes on a photo?

select
    users.username,
    photos.id,
    photos.image_url,
    count(*) as total
from photos
inner join likes
    on likes.photo_id = photos.id
inner join users
    on users.id = photos.user_id
group by photos.id
order by total desc
limit 1;



-- QUESTION 5:
-- How many times does the average user post?

select (select count(*) from photos) / (select count(*) from users) as average_post_per_user;



-- QUESTION 6:
-- What are the top 5 most commonly used hashtags?

select
    tag_name,
    count(*) as tag_used
from tags
inner join photo_tags
    on tags.id = photo_tags.tag_id
group by tags.id
order by tag_used desc
limit 5;



-- QUESTION 7:
-- Find users who liked every single photo on the site?

select
    users.id,
    users.username,
    COUNT(*) as num_likes
from users
inner join likes
    on users.id = likes.user_id
group by users.id
having num_likes = (select count(*) from photos);