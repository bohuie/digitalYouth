SELECT  (SELECT COUNT(job_postings.id) AS JobPostings FROM job_postings), 
	(SELECT COUNT(job_posting_skills.id) AS JobPostingSkills FROM job_posting_skills),
	(SELECT COUNT(skills.id) AS Skills FROM Skills),
	(SELECT COUNT(job_categories.id) AS JobCategories FROM job_categories)