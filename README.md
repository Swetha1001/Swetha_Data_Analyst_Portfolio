# Data Jobs Data Analysis using Python

This project analyses the data job market, focusing on data analyst roles. This project was created out of a desire to navigate and understand the job market more effectively.

The data sourced from [Luke Barousse's Python Course](https://lukebarousse.com/python) which provides a foundation for my analysis, containing detailed information on job titles, salaries, locations, and essential skills. Through a series of Python scripts, I explore key questions such as the most demanded skills, salary trends, and the intersection of demand and salary in data analytics.
---

📁 Project Structure
- `Job Market Analysis`: SQL scripts used for analysis.
- `Salary Analysis`: Power BI dashboard file.   
- `Skills_Trend`: Screenshot preview of the final dashboard.
- `Data_jobs.csv`: Excel Dataset
- `README.md`: Project documentation.

---

# The Questions

-Clean and preprocess raw job posting data using Python and Pandas.
-Analyze hiring trends across job titles, companies, and locations.
-Identify the most in-demand data roles and required skills.
-Identify the number of data job postings changed over time.
-Analyze salaries across different countries.
-Find the percentages of the total job entries per month.
-Visualize insights using Seaborn and Matplotlib for better interpretation.

---
# Tools I Used

For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **Python:** The backbone of my analysis, allowing me to analyze the data and find critical insights.I also used the following Python libraries:
    - **Pandas Library:** This was used to analyze the data. 
    - **Matplotlib Library:** I visualized the data.
    - **Seaborn Library:** Helped me create more advanced visuals. 
- **Jupyter Notebooks:** The tool I used to run my Python scripts which let me easily include my notes and analysis.
- **Visual Studio Code:** My go-to for executing my Python scripts.
- **Git & GitHub:** Essential for version control and sharing my Python code and analysis, ensuring collaboration and project tracking.

---

# Data Preparation and Cleanup

This section outlines the steps taken to prepare the data for analysis, ensuring accuracy and usability.

## Import & Clean Up Data

I start by importing necessary libraries and loading the dataset, followed by initial data cleaning tasks to ensure data quality.

```python
# Importing Libraries
import ast
import pandas as pd
import seaborn as sns
from datasets import load_dataset
import matplotlib.pyplot as plt  

# Loading Data
dataset = load_dataset('lukebarousse/data_jobs')
df = dataset['train'].to_pandas()

# Data Cleanup
df['job_posted_date'] = pd.to_datetime(df['job_posted_date'])
df['job_skills'] = df['job_skills'].apply(lambda x: ast.literal_eval(x) if pd.notna(x) else x)
```
---

## Filter US Jobs

To focus my analysis on the U.S. job market, I apply filters to the dataset, narrowing down to roles based in the United States.

```python
df_US = df[df['job_country'] == 'United States']

```

# Job Market Analysis:

Each Jupyter notebook for this project aimed at investigating specific aspects of the data job market. Here’s how I approached each question:

## 1.  What are the most in-demand data job roles?

```python
df_plot = df['job_title_short'].value_counts().to_frame()

sns.set_theme(style='ticks')
sns.barplot(data=df_plot, x='count', y='job_title_short', hue='count', palette='dark:b_r', legend=False)
sns.despine()
plt.title('Number of Jobs per Job Title')
plt.xlabel('Number of Jobs')
plt.ylabel('')
plt.show()
```

This visualization highlights which data-related roles appear most frequently in job postings.
By analyzing the counts of each job title, we can identify where hiring demand is concentrated in the data industry.

Key Insights:

👩‍💻 Data Analyst roles dominate the job market, representing the highest number of postings.

🧠 Data Engineer and Data Scientist positions follow closely, showing strong demand for analytical and technical expertise.

💼 Specialized roles such as Business  Analyst, Software Engineer and Senior Data Engineer have moderate but consistent openings.


## 2. Which companies are hiring the most for data-related positions?


```python
df_plot = df['company_name'].value_counts().to_frame()[1:].head(20)

sns.set_theme(style='ticks')
sns.barplot(data=df_plot, x='count', y='company_name', hue='count', palette='dark:b_r', legend=False)
sns.despine()
plt.title('Number of Jobs per Company')
plt.xlabel('Number of Jobs')
plt.ylabel('')
plt.show()
```
This visualization highlights the companies hiring the most for data-related positions.
By analyzing the number of job postings per company, we can identify which organizations are driving demand in the data job market.


This visualization highlights the top companies actively hiring for data-related positions.
By analyzing the number of job postings per company, we can identify key organizations leading the demand for data professionals.

Key Insights:

🏢 Booz Allen Hamilton, Dice, and Harnham are among the top employers, showing a strong demand for data professionals.
📊 It is then followed by Insight Global, Citi and Confidenziale which also has a high volume of job listings, emphasizing the growing role of analytics and data consulting.
🚀 These trends indicate a healthy job market across diverse industries, offering opportunities for analysts, engineers, and data scientists alike.


## 3.  How has the number of data job postings changed over time?

```python
df['month'] = df['job_posted_date'].dt.to_period('M')
monthly_trend = df['month'].value_counts().sort_index()

plt.figure(figsize=(10,5))
monthly_trend.plot(kind='line', marker='o')
plt.title("Monthly Data Job Postings Over Time")
plt.xlabel("Month")
plt.ylabel("Number of Job Postings")
plt.xticks(rotation=45)
plt.show()
```

This visualization shows how the number of data-related job postings has changed over time.
By converting job posting dates into monthly periods, it uncovers patterns and seasonality in hiring activity.

Key Insights:

📈 January recorded the highest number of job postings, indicating a strong hiring phase for data professionals. It is then followed by August.
📉 May month saw the lowest number of postings.
📊 The trend line slowdowns toward the end of the year, likely due to year-end holidays and budget closures.


## 4. What percentage of jobs are Remote vs Not Remote?

```python
remote_counts = df['job_work_from_home'].value_counts()

plt.figure(figsize=(6,6))
remote_counts.plot(kind='pie', autopct='%1.1f%%', labels=['Not Remote', 'Remote'], explode=[0,0.1])
plt.title("Remote vs Not Remote Job Distribution")
plt.ylabel("")
plt.show()
```

This visualization shows the distribution of remote vs non-remote data job postings.
It helps identify how common remote work opportunities are within the data job market.

Key Insights:

🏠 Only 8.9% of data job postings are remote, indicating that fully remote roles remain relatively limited.
🏢 A large majority — 91.1% of postings — are not remote, suggesting that most companies still prefer on-site or hybrid arrangements for data positions.
💡 This highlights that while remote data jobs exist, they represent a small fraction of the overall market, making location flexibility less common in the data domain.
📊 Organizations may still value in-person collaboration, access to secure systems, or team-based workflows in data projects.



## 5. Which locations have the highest number of job postings

```python

top_locations = df['job_location'].value_counts().head(10)

plt.figure(figsize=(8,5))
sns.barplot(x=top_locations.values, y=top_locations.index)
plt.title("Top 10 Hiring Locations for Data Roles")
plt.xlabel("Number of Postings")
plt.ylabel("Location")
plt.show()
```
This visualization highlights the top locations with the highest number of data-related job postings.
It provides insights into where demand for data professionals is concentrated globally.

Key Insights:

📍 Anywhere (Remote) accounts for the largest number of postings, showing strong flexibility for some roles.
🌏 Singapore follows closely, reflecting a growing hub for data analytics and tech jobs in Asia.
🇫🇷 Paris, France is also among the top locations, highlighting Europe’s contribution to the global data job market.
🇮🇳 Bengaluru, Karnataka, India and 🇬🇧 London, UK come next, indicating strong hiring activity in both Asian and European tech centers.
💼 These trends show that while remote opportunities exist, major global cities remain key hubs for data professionals, offering diverse opportunities across analytics, engineering, and data science.
---

##Salary Analysis:
“Each Jupyter notebook in this project focuses on exploring different aspects of salary analysis. The following outlines my approach to each research question:”

## 1. Salary by Job Titles
```python
top_roles = df.groupby('job_title_short')['salary_year_avg'].mean().sort_values(ascending=False).head(10)

plt.figure(figsize=(8,5))
sns.barplot(x=top_roles.values, y=top_roles.index)
plt.title("Top 10 Highest Paying Jobs")
plt.xlabel("Average Salary (USD)")
plt.ylabel("Job Title")
plt.show()
```

This visualization displays the average salary for different data-related job titles, highlighting the highest-paying roles in the industry.

Key Insights:

💰 Senior Data Scientist tops the list as the highest-paying role, reflecting its advanced expertise and responsibilities.
🧠 Senior Data Engineer follows closely, indicating strong compensation for technical engineering leadership.
📊 Roles like Data Scientist, Data Engineer, and Machine Learning Engineer also offer competitive salaries, making them attractive career options.
💡 Overall, senior-level positions command the highest pay, while specialized technical roles continue to be well-compensated in the data industry.


## 2. Salary by Country
```python

top_countries = df.groupby('job_country')['salary_year_avg'].mean().sort_values(ascending=False).head(10)

plt.figure(figsize=(8,5))
sns.barplot(x=top_countries.values, y=top_countries.index)
plt.title("Top 10 Countries by Average Salary")
plt.xlabel("Average Salary (USD)")
plt.ylabel("Country")
plt.show()
```

This visualization shows the average salary for data jobs across different countries, highlighting the highest-paying regions.

Key Insights:

🌍 Belarus tops the list with a significantly higher average salary, making it a clear outlier.
🇷🇺 Russia comes next, with a large difference from the remaining countries.
🇧🇸 Bahamas ranks third, followed by
🇩🇴 Dominican Republic and 🇲🇵 Northern Mariana Islands, which have similar average salaries and cluster closely together.
💡 These results indicate that while a few countries dominate in compensation, smaller or niche markets also provide competitive opportunities for data professionals globally.

## 3. Salary Distribution by Job Title in US

```python
# filter data to only include salary values from India

df_US = df[(df['job_country'] == 'United States')].dropna(subset=['salary_year_avg'])
```

```python
job_titles = df_US['job_title_short'].value_counts().index[:6].tolist()

# filter the df for the top 6 job titles
df_US_top6 = df_US[df_US['job_title_short'].isin(job_titles)]

# order the job titles by median salary
job_order = df_US_top6.groupby('job_title_short')['salary_year_avg'].median().sort_values(ascending=False).index

job_titles
```
```python
#Plot the top 6 job titles salary distributions using a box plot.

sns.boxplot(data=df_US_top6, x='salary_year_avg', y='job_title_short', order=job_order)
sns.set_theme(style='ticks')
sns.despine()

plt.title('Salary Distributions of Data Jobs in the US')
plt.xlabel('Yearly Salary (USD)')
plt.ylabel('')
plt.xlim(0, 600000)
ticks_x = plt.FuncFormatter(lambda y, pos: f'${int(y/1000)}K')
plt.gca().xaxis.set_major_formatter(ticks_x)
plt.show()
```

#### Results

![Salary Distributions of Data Jobs in the US](images/Salary_Distributions_of_Data_Jobs_in_the_US.png)  
*Box plot visualizing the salary distributions for the top 6 data job titles.*

#### Insights

- There's a significant variation in salary ranges across different job titles. Senior Data Scientist positions tend to have the highest salary potential, with up to $600K, indicating the high value placed on advanced data skills and experience in the industry.

- Senior Data Engineer and Senior Data Scientist roles show a considerable number of outliers on the higher end of the salary spectrum, suggesting that exceptional skills or circumstances can lead to high pay in these roles. In contrast, Data Analyst roles demonstrate more consistency in salary, with fewer outliers.

- The median salaries increase with the seniority and specialization of the roles. Senior roles (Senior Data Scientist, Senior Data Engineer) not only have higher median salaries but also larger differences in typical salaries, reflecting greater variance in compensation as responsibilities increase.






### Highest Paid & Most Demanded Skills for Data Analysts

Next, I narrowed my analysis and focused only on data analyst roles. I looked at the highest-paid skills and the most in-demand skills. I used two bar charts to showcase these.

#### Visualize Data

```python

fig, ax = plt.subplots(2, 1)  

# Top 10 Highest Paid Skills for Data Analysts
sns.barplot(data=df_DA_top_pay, x='median', y=df_DA_top_pay.index, hue='median', ax=ax[0], palette='dark:b_r')

# Top 10 Most In-Demand Skills for Data Analystsr')
sns.barplot(data=df_DA_skills, x='median', y=df_DA_skills.index, hue='median', ax=ax[1], palette='light:b')

plt.show()

```

#### Results
Here's the breakdown of the highest-paid & most in-demand skills for data analysts in the US:

![The Highest Paid & Most In-Demand Skills for Data Analysts in the US](images/Highest_Paid_and_Most_In_Demand_Skills_for_Data_Analysts_in_the_US.png)
*Two separate bar graphs visualizing the highest paid skills and most in-demand skills for data analysts in the US.*

#### Insights:

- The top graph shows specialized technical skills like `dplyr`, `Bitbucket`, and `Gitlab` are associated with higher salaries, some reaching up to $200K, suggesting that advanced technical proficiency can increase earning potential.

- The bottom graph highlights that foundational skills like `Excel`, `PowerPoint`, and `SQL` are the most in-demand, even though they may not offer the highest salaries. This demonstrates the importance of these core skills for employability in data analysis roles.

- There's a clear distinction between the skills that are highest paid and those that are most in-demand. Data analysts aiming to maximize their career potential should consider developing a diverse skill set that includes both high-paying specialized skills and widely demanded foundational skills.

## 4. What are the most optimal skills to learn for Data Analysts?

To identify the most optimal skills to learn ( the ones that are the highest paid and highest in demand) I calculated the percent of skill demand and the median salary of these skills. To easily identify which are the most optimal skills to learn. 

View my notebook with detailed steps here: [5_Optimal_Skills](5_Optimal_Skills.ipynb).

#### Visualize Data

```python
from adjustText import adjust_text
import matplotlib.pyplot as plt

plt.scatter(df_DA_skills_high_demand['skill_percent'], df_DA_skills_high_demand['median_salary'])
plt.show()

```

#### Results

![Most Optimal Skills for Data Analysts in the US](images/Most_Optimal_Skills_for_Data_Analysts_in_the_US.png)    
*A scatter plot visualizing the most optimal skills (high paying & high demand) for data analysts in the US.*

#### Insights:

- The skill `Oracle` appears to have the highest median salary of nearly $97K, despite being less common in job postings. This suggests a high value placed on specialized database skills within the data analyst profession.

- More commonly required skills like `Excel` and `SQL` have a large presence in job listings but lower median salaries compared to specialized skills like `Python` and `Tableau`, which not only have higher salaries but are also moderately prevalent in job listings.

- Skills such as `Python`, `Tableau`, and `SQL Server` are towards the higher end of the salary spectrum while also being fairly common in job listings, indicating that proficiency in these tools can lead to good opportunities in data analytics.

### Visualizing Different Techonologies

Let's visualize the different technologies as well in the graph. We'll add color labels based on the technology (e.g., {Programming: Python})

#### Visualize Data

```python
from matplotlib.ticker import PercentFormatter

# Create a scatter plot
scatter = sns.scatterplot(
    data=df_DA_skills_tech_high_demand,
    x='skill_percent',
    y='median_salary',
    hue='technology',  # Color by technology
    palette='bright',  # Use a bright palette for distinct colors
    legend='full'  # Ensure the legend is shown
)
plt.show()

```

#### Results

![Most Optimal Skills for Data Analysts in the US with Coloring by Technology](images/Most_Optimal_Skills_for_Data_Analysts_in_the_US_with_Coloring_by_Technology.png)  
*A scatter plot visualizing the most optimal skills (high paying & high demand) for data analysts in the US with color labels for technology.*

#### Insights:

- The scatter plot shows that most of the `programming` skills (colored blue) tend to cluster at higher salary levels compared to other categories, indicating that programming expertise might offer greater salary benefits within the data analytics field.

- The database skills (colored orange), such as Oracle and SQL Server, are associated with some of the highest salaries among data analyst tools. This indicates a significant demand and valuation for data management and manipulation expertise in the industry.

- Analyst tools (colored green), including Tableau and Power BI, are prevalent in job postings and offer competitive salaries, showing that visualization and data analysis software are crucial for current data roles. This category not only has good salaries but is also versatile across different types of data tasks.

# What I Learned

Throughout this project, I deepened my understanding of the data analyst job market and enhanced my technical skills in Python, especially in data manipulation and visualization. Here are a few specific things I learned:

- **Advanced Python Usage**: Utilizing libraries such as Pandas for data manipulation, Seaborn and Matplotlib for data visualization, and other libraries helped me perform complex data analysis tasks more efficiently.
- **Data Cleaning Importance**: I learned that thorough data cleaning and preparation are crucial before any analysis can be conducted, ensuring the accuracy of insights derived from the data.
- **Strategic Skill Analysis**: The project emphasized the importance of aligning one's skills with market demand. Understanding the relationship between skill demand, salary, and job availability allows for more strategic career planning in the tech industry.


# Insights

This project provided several general insights into the data job market for analysts:

- **Skill Demand and Salary Correlation**: There is a clear correlation between the demand for specific skills and the salaries these skills command. Advanced and specialized skills like Python and Oracle often lead to higher salaries.
- **Market Trends**: There are changing trends in skill demand, highlighting the dynamic nature of the data job market. Keeping up with these trends is essential for career growth in data analytics.
- **Economic Value of Skills**: Understanding which skills are both in-demand and well-compensated can guide data analysts in prioritizing learning to maximize their economic returns.


# Challenges I Faced

This project was not without its challenges, but it provided good learning opportunities:

- **Data Inconsistencies**: Handling missing or inconsistent data entries requires careful consideration and thorough data-cleaning techniques to ensure the integrity of the analysis.
- **Complex Data Visualization**: Designing effective visual representations of complex datasets was challenging but critical for conveying insights clearly and compellingly.
- **Balancing Breadth and Depth**: Deciding how deeply to dive into each analysis while maintaining a broad overview of the data landscape required constant balancing to ensure comprehensive coverage without getting lost in details.


# Conclusion

This exploration into the data analyst job market has been incredibly informative, highlighting the critical skills and trends that shape this evolving field. The insights I got enhance my understanding and provide actionable guidance for anyone looking to advance their career in data analytics. As the market continues to change, ongoing analysis will be essential to stay ahead in data analytics. This project is a good foundation for future explorations and underscores the importance of continuous learning and adaptation in the data field.



