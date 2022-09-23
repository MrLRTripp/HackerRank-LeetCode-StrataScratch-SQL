-- Find the email activity rank for each user. Email activity rank is defined by the total number of emails sent. 
-- The user with the highest number of emails sent will have a rank of 1, and so on. Output the user, total emails, and 
-- their activity rank. Order records by the total emails in descending order. Sort users with the same number of emails 
-- in alphabetical order.
-- In your rankings, return a unique value (i.e., a unique rank) even if multiple users have the same number of emails.

-- We use ROW_NUMBER() since it asks for unique numbers in case of a tie.
-- The window order by has two values since the problem asks to rank by cound descending and user name ascending in case of a tie
SELECT from_user,
       COUNT(from_user) AS total_emails,
       ROW_NUMBER() OVER (
                          ORDER BY COUNT(from_user) DESC, from_user asc) AS user_rank
FROM google_gmail_emails
GROUP BY from_user
order by user_rank asc