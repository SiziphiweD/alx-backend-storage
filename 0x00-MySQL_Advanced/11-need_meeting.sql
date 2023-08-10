-- Create a view need_meeting based on the given criteria
CREATE VIEW need_meeting AS
SELECT * FROM students
WHERE score < 80 AND (last_meeting IS NULL OR last_meeting < DATE_SUB(NOW(), INTERVAL 1 MONTH));

