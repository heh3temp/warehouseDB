DROP VIEW IF EXISTS employeesInformation;

CREATE VIEW employeesInformation AS
SELECT 
    e.name,
    e.surname,
    p.name AS position,
    e.salary,
    h.name AS hala
FROM
    alleys AS a
LEFT JOIN
    halls AS h ON (h.hall_id = a.hall_id)
RIGHT JOIN
    employees AS e ON (
        a.warehouseman_id = e.employee_id
        OR h.manager_id = e.employee_id
    )
LEFT JOIN
    positions AS p ON (e.position_id = p.position_id)
GROUP BY e.employee_id;