DELIMITER //
CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    DECLARE user_id INT;
    DECLARE done INT DEFAULT 0;
    
    -- Declare cursor to iterate over user IDs
    DECLARE cur CURSOR FOR
    SELECT id FROM users;
    
    -- Declare continue handler for cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    -- Open the cursor
    OPEN cur;
    
    -- Loop through users and compute average weighted score
    read_loop: LOOP
        FETCH cur INTO user_id;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Call the ComputeAverageWeightedScoreForUser procedure for each user
        CALL ComputeAverageWeightedScoreForUser(user_id);
    END LOOP;
    
    -- Close the cursor
    CLOSE cur;
END //
DELIMITER ;

