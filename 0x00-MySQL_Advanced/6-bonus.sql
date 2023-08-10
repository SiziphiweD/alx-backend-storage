-- Create stored procedure for adding bonus corrections
DELIMITER //
CREATE PROCEDURE AddBonus(IN user_id INT, IN project_name VARCHAR(255), IN score INT)
BEGIN
    DECLARE project_id INT;
    DECLARE user_count INT;
    DECLARE last_inserted_id INT;
    
    SELECT COUNT(*) INTO user_count FROM users WHERE id = user_id;
    
    IF user_count = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid user_id';
    END IF;
    
    SELECT id INTO project_id FROM projects WHERE name = project_name;
    
    IF project_id IS NULL THEN
        INSERT INTO projects (name) VALUES (project_name);
        SET project_id = LAST_INSERT_ID();
    END IF;
    
    INSERT INTO corrections (user_id, project_id, score) VALUES (user_id, project_id, score);
    
    SELECT id INTO last_inserted_id FROM corrections WHERE id = LAST_INSERT_ID();
    CALL ComputeAverageScoreForUser(user_id);
    
    -- Optional: You can return the last_inserted_id if needed
    SELECT last_inserted_id AS 'New_Correction_ID';
END;
//
DELIMITER ;

