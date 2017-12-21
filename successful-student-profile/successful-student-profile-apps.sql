SELECT DISTINCT a.id AS application_id,
                a.cohort_id,
                a.applicant_id,
                a.nd_key,
                a.application_type,
                coalesce(a.applicant_country,'Unknown') AS applicant_country,
                coalesce(a.applicant_geo,'Unknown') AS applicant_geo,
                CASE
                    WHEN reg.state = 'GRADUATED'
                         OR grad.graduated_at IS NOT NULL THEN 'graduated'
                    WHEN b.user_id IS NOT NULL THEN 'term completed'
                    WHEN a.first_charge_created_at IS NOT NULL
                         AND a.accepted_at IS NOT NULL THEN 'paid'
                    WHEN a.accepted_at IS NOT NULL THEN 'accepted'
                    WHEN a.rejected_at IS NOT NULL THEN 'rejected'
                    WHEN a.submitted_at IS NOT NULL THEN 'submitted'
                    ELSE 'applied'
                END AS application_status,
                CURRENT_DATE - a.applicant_created_at::date AS user_age,
                               a.cohort_notify_at::date - a.cohort_open_at::date AS cohort_open_to_notify,
                               a.cohort_close_at::date - a.cohort_open_at::date AS cohort_open_to_close,
                               date_part('month',a.cohort_open_at) AS cohort_open_month,
                               date_part('month',a.application_created_at) AS application_month,
                               a.application_created_at::date - a.cohort_open_at::date AS apply_before_start,
                               a.submitted_at::date - a.application_created_at::date AS apply_to_submit,
                               coalesce(a.accepted_at,a.rejected_at)::date - a.submitted_at::date AS submit_to_decision,
                               a.cohort_notify_at::date - a.submitted_at::date AS submit_to_notify,
                               greatest(coalesce(c.first_charge_attempt::date,a.first_charge_created_at::date) - a.cohort_notify_at::date,0) AS notify_to_pay,
                               coalesce(a.price,0)::int AS price
FROM admissions.applications AS a
LEFT JOIN enrollments.term_completions AS b ON a.applicant_id = b.user_id AND a.nd_key = b.nd_key
LEFT JOIN
  (SELECT DISTINCT account_key,
                   nd_key,
                   cohort_id,
                   charge_created_at,
                   first_value(charge_created_at) over (partition BY account_key,nd_key,cohort_id
                                                        ORDER BY charge_created_at) AS first_charge_attempt
   FROM payments.charges
   WHERE charge_status IN ('paid',
                           'authorized')
   GROUP BY account_key,
            nd_key,
            cohort_id,
            charge_created_at) AS c ON a.applicant_id = c.account_key
AND (CASE
         WHEN a.application_type = 'connect' THEN substring(a.nd_key,0,14)
         WHEN a.application_type = 'term' THEN substring(a.nd_key,0,6)
     END) = c.nd_key
AND (CASE
         WHEN a.application_type = 'term' THEN a.cohort_id::int
         ELSE 0
     END) = coalesce(c.cohort_id,0)
AND c.charge_created_at >= a.application_created_at
LEFT JOIN enrollments.nanodegree_graduations_segment AS grad ON a.applicant_id = grad.user_id
AND substring(a.nd_key,0,6) = substring(grad.nanodegree,0,6)
LEFT JOIN enrollments.nanodegree_enrollments_registrar AS reg ON a.applicant_id = reg.user_id
AND substring(a.nd_key,0,6) = substring(reg.course_key,0,6)
WHERE accepted_at IS NOT NULL
  AND first_charge_created_at IS NOT NULL
  AND application_type != 'scholarship'
  AND email NOT LIKE '%@udacity%'