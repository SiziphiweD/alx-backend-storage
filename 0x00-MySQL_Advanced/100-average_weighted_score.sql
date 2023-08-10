DELIMITER //
CREATE PROCEDURE ComputeAverageWeightedScoreForUser(IN user_id INT)
BEGIN
    DECLARE total_score FLOAT;
    DECLARE total_weight INT;
    DECLARE avg_score FLOAT;
    
    -- Calculate the total score and total weight for the user
    SELECT SUM(c.score * p.weight), SUM(p.weight)
    INTO total_score, total_weight
    FROM corrections c
    JOIN projects p ON c.project_id = p.id
    WHERE c.user_id = user_id;
    
    -- Calculate the average weighted score
    SET avg_score = IF(total_weight > 0, total_score / total_weight, 0);
    
    -- Update the average_score for the specified user
    UPDATE users
    SET average_score = avg_score
    WHERE id = user_id;
END //
DELIMITER ;

