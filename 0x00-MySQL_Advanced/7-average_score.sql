-- Create stored procedure for computing average score for a user
DELIMITER //
CREATE PROCEDURE ComputeAverageScoreForUser(IN user_id INT)
BEGIN
    DECLARE user_count INT;
    DECLARE user_avg FLOAT;
    
    SELECT COUNT(*) INTO user_count FROM users WHERE id = user_id;
    
    IF user_count = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid user_id';
    END IF;
    
    SELECT AVG(score) INTO user_avg FROM corrections WHERE user_id = user_id;
    
    UPDATE users SET average_score = user_avg WHERE id = user_id;
END;
//
DELIMITER ;

