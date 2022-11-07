delimiter $$

create trigger anti_self_follow
    before insert on follows for each row
    begin
        if new.follower_id = new.followee_id
        then
            signal sqlstate '45000'
            set MESSAGE_TEXT = 'A user cannot follow themselves!';
        end if;
    end;
$$

delimiter;