## SQL & Product Metrics

Given the following tables, answer questions below.
An application is considered not submitted if application_submitted_at has no values.


```
SELECT * FROM accounts;

user_id   first_name    last_name
1         John          Doe
2         Jane          Don
3         Alice         Jones
4         Lisa          Romero
5         Paul          Oh

SELECT * FROM training_details;

application_id  user_id  course_id  application_creation_date  application_submitted_at
1               1        1          "2015-08-02"               "2015-08-06”
2               2        1          "2015-08-03"                 
3               3        2          "2015-08-02"               "2015-08-02”
4               4        2          "2015-08-04"               "2015-08-09”
5               2        2          "2015-08-03"               "2015-09-12”
6               1        1          "2015-08-02"                   
7               3        2          "2015-08-04"               "2015-08-04”
8               4        3          "2015-08-03"               "2015-08-03”
9               5        4          "2015-08-03"                  
10              3        1          "2015-08-02"               "2015-08-06”
11              4        2          "2015-08-04"               "2015-08-07”
12              5        2          "2015-08-02"                    
13              1        1          "2015-08-02"               "2015-08-08”
14              4        3          "2015-08-03"               "2015-08-03”

SELECT * FROM countrys;

user_id   country_code
1         US
2         US
3         UK
4         UK
5.        KR

SELECT * FROM calendars;

date
"2015-08-01”
"2015-08-02"
"2015-08-03"
"2015-08-04"
"2015-08-05”
"2015-08-06”

```


### Question 1

Write a SQL query to find out how many applications each user created by user_id.


### Question 2

Write a SQL query to find out how many applications each user submitted by user_id.


### Question 3

Write a SQL query to find out how many applications created every day from 8/1 to 8/6 (if there’s no applications created show 0).


### Question 4

Write a SQL query to calculate the average applications user submitted. Your output will be a number. (E.g. if your number is 3 means averagely a user will submit 3 applications.)


### Question 5

Write a SQL query to find out the number of courses user applied, submitted and average days taken to submit (submitted_at - application_creation) by user name in format like “John Doe”.


### Question 6

Write a SQL query to find out the top 2 countries have higher submit rate (# of application submitted / # of application created)




