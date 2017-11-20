SELECT application_id,
       cohort_id,
       user_id AS applicant_id,
       nanodegree_key AS nd_key ,
       count(DISTINCT course_key) AS num_courses ,
       count(DISTINCT CASE
                          WHEN course_finished = 2 THEN course_key
                          ELSE NULL
                      END) AS num_course_finished ,
       count(DISTINCT CASE
                          WHEN course_finished = 1 THEN course_key
                          ELSE NULL
                      END) AS num_course_enrolled ,
       CURRENT_DATE - first_course_started_at::date AS user_study_age
FROM
  (SELECT DISTINCT b.application_id,
                   b.cohort_id,
                   a.user_id,
                   b.nanodegree_key,
                   course_key,
                   join_time,
                   leave_time ,
                   first_value(join_time) over (partition BY a.user_id
                                                ORDER BY join_time ROWS BETWEEN unbounded preceding AND unbounded following) AS first_course_started_at ,
                   CASE
                       WHEN a.leave_time::Date <= b.received_at::Date THEN 2
                       WHEN a.leave_time IS NOT NULL THEN 1
                       ELSE 0
                   END AS course_finished
   FROM analytics_tables.course_enrollments AS a
   INNER JOIN backend_admissions.application_received AS b ON a.user_id = b.user_id
   WHERE a.join_time <= b.received_at )
GROUP BY application_id,
         cohort_id,
         user_id,
         nanodegree_key,
         CURRENT_DATE - first_course_started_at::date