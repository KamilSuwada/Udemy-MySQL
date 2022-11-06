CREATE TABLE students
(
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100)
);



CREATE TABLE papers
(
    title VARCHAR(250),
    grade INT,
    student_id INT,
    FOREIGN KEY(student_id) REFERENCES students(id)
    ON DELETE CASCADE
);




INSERT INTO students (name) VALUES 
('Caleb'), ('Samantha'), ('Raj'), ('Carlos'), ('Lisa');



INSERT INTO papers (student_id, title, grade) VALUES
(1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through The Ages', 94),
(2, 'De Montaigne and The Art of The Essay', 98),
(4, 'Borges and Magical Realism', 89);





-- Show all students and the papers they submitted. If no submission, "NO SUBMISSION!" will be displayed.
select 
	name,
    ifnull(title, "NO SUBMISSION!") as title,
    ifnull(grade, 0) as grade
from students
left join papers
    on students.id = papers.student_id
order by grade desc;



-- Show average for every student.
select
    name,
    ifnull
    (
        round
        (
            avg(grade),
            2
        ),
        0
    ) as average
from students
left join papers
    on students.id = papers.student_id
group by students.id
order by grade desc;



-- Show all students, their average and if they pass the class.
select
    name,
    ifnull
    (
        round
        (
            avg(grade),
            2
        ),
        0
    ) as average,
    case
    	when avg(grade) is null then "FAILING - NO SUBMISSION"
    	when avg(grade) >= 75 then "PASSING"
        else "FAILING"
    end as progression
from students
left join papers
    on students.id = papers.student_id
group by students.id
order by grade desc;





drop table papers;
drop table students;