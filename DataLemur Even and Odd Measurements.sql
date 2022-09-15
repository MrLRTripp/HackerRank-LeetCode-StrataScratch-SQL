-- Assume you are given the table below containing measurement values obtained from a sensor over several days. 
-- Measurements are taken several times within a given day.
-- Write a query to obtain the sum of the odd-numbered and even-numbered measurements on a particular day, in two 
-- different columns.
-- Note that the 1st, 3rd, 5th measurements within a day are considered odd-numbered measurements and the 2nd, 4th, 
-- 6th measurements are even-numbered measurements.

with cte_m_num as (
  SELECT measurement_time::date m_date, measurement_value,
  row_number() over (PARTITION BY measurement_time::date ORDER BY measurement_time ASC) measurement_num
  FROM measurements
)
select m_date,
ROUND(SUM(case when (measurement_num % 2) = 1 then measurement_value end),2) sum_of_odd,
ROUND(SUM(case when (measurement_num % 2) = 0 then measurement_value end),2) sum_of_even

from cte_m_num
GROUP BY m_date
ORDER BY m_date ASC