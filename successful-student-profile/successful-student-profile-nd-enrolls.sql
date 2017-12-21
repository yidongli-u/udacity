SELECT distinct a.id as application_id,left(n.nd_key,5) as nd_key
      ,case when reg.state = 'GRADUATED' or coalesce(grad.graduated_at,n.graduated_at) is not null then 'GRADUATED'
            when coalesce(t_c.term_completed_at,n.term_completed_at) is not null then 'TERM_COMPLETED'
            when reg.unenrolled_at is not null and reg.state = 'UNENROLLED' then 'CANCELLED'
            when reg.state is null AND n.access_ended_at::date - n.access_started_at::date <= 7 then 'TRIAL_ENDED'
       else reg.state end AS status
FROM applications a
LEFT JOIN nd_enrolls n ON a.applicant_id = n.user_id AND a.application_created_at >= n.access_started_at AND n.has_payment
LEFT JOIN enrollments.nanodegree_graduations_segment AS grad ON n.user_id = grad.user_id AND n.nd_key = grad.nanodegree
LEFT JOIN enrollments.nanodegree_enrollments_registrar AS reg ON n.user_id = reg.user_id AND n.nd_key = reg.course_key
LEFT JOIN enrollments.term_completions AS t_c ON n.user_id = t_c.user_id AND n.nd_key = t_c.nd_key
WHERE NOT (reg.state is null OR reg.state = 'INTERESTED')
  AND a.email not like '%@udacity%'
ORDER BY a.id