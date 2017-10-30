## Product Metrics

About how the candidate approach a biz question.

### Question 1

Draw a line graph in white board (if possible), showing % of applications received along time (month). Draw a spike in July.

#### 1) Your Application PM finds you, ask you what is causing the spike in July. What would you do?

e.g. what’s driving? new course? new feature launched? channel (thru udacity.com? FB? Google? Email?); device (PC? Pad? Phone?); seasonality (yearly historical data); user profile (fresh out of school? career intent - change jobs?); region (launch in new region? New course in certain region?); course category (DS? SDC?)

#### 2) Say you found that there was an email campaign in July, might be driving the spike. Now the marketing team wants to launch another email campaign and asking for your help. How would you set it up?

e.g. a/b testing

#### 3) The process of application is: student click into the page, they can create an application but not necessary submit it unless they click submit. So there’s 2 metrics to measure: click to apply; click to submit application. How do you define the metric to measure success? 

e.g. ask the candidate to write down numerator and denominator. do they use “click” or use “unique users”?

#### 4) How do you define sample size?

e.g. power~ CI~

#### 5) Write down the H0 and H1.

#### 6) Say control group is 50%, experiment group is 55%, how do you interpret?

e.g. write down the t-test statistics etc.



### Question 2

#### 1) If we want to calculate the probability of a student’s graduation from a course, what features would you consider?

e.g. education level? employed? how many courses registered in the past? how many courses have been finished in the past? Status in the learning life cycle (just joined? Finished 20%? Towards 90%?)

##### 1) follow up - (If candidate didn’t mention status in learning life cycle, ask: is the prob. going to be static thru the student’s learning cycle?)

#### 2) What kind of model would you consider to do the calculation (predict probability of graduation)?

e.g. logistics regression, regression, any classification methods

##### 2) follow up - Why this model?

e.g. regression / logistics regression is easy to interpret, and more actionable

#### 3) How do you test if all the features you mentioned above are relevant to the target (prob. of graduation)?

e.g. correlation test, heatmap viz, regression / logistics regression on all features

##### 3) follow up - If you do a correlation test, how can you define relevant or not? (R^2 > 0.6? 0.8? Why?)
##### 3) follow up - Why regression not logistics regression? / Why logistics regression not regression? Are they the same? Why? (Distribution different)

#### 4) Now you are presenting to your PM trying to explain if Education Level (any features candidate mentioned above) is driving prob. of graduation. Say you are using a logistics regression model. What variables you will use to explain to your PM?

e.g. t-value? P-values?

#### 5) Say the p-value is 0.04, how would you explain?

e.g. significant? What does ‘significant’ mean?

#### 6) Now you tested out all the features you mentioned above, using either correlation or logistics regression, figured that all the features are not significant to the prob. of graduation, what’s your next step?

e.g. talked to SMEs in the industry to understand if they have ideas from experience; combine features together (e.g. combine education and gender, treat as a new feature)

#### 7) Say now you have a model set up and running to calculate the prob. of graduation of a student given a student’s status, with the accuracy of 90%. What kind of suggestions would you give to your stakeholders? For example, 2 students join at the same time, student A has % of grad. at 90%, student B has % of grad. at 50%, what suggestions you will give to the course manager?

e.g. engage earlier with student B than student A, regarding to the features in the model

#### 8) Say we launched the model above 3 months ago, it was at 90% accuracy. Now 3 months after, the accuracy drops to 70%. What would you do?

e.g. supposedly the candidate should bring up the frequency of reviewing the model, every day? every month? In what frequency, why? Could be resources, etc.





