delimiter $$

create trigger unfollow_trigger
    after delete on follows for each row
    begin
        insert into unfollows(follower_id, followee_id)
        values(OLD.follower_id, OLD.followee_id);
    end;
$$

delimiter;