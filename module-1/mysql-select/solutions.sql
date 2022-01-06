--- Challenge 1 - Who Have Published What At Where?

SELECT a.au_id "AUTHOR ID", a.au_lname "LAST NAME", a.au_fname "FIRST NAME", t.title "TITLE", p.pub_name "PUBLISHER"
FROM AUTHORS a 
JOIN TITLEAUTHOR ta ON a.au_id=ta.au_id
JOIN TITLES t ON ta.title_id=t.title_id
JOIN PUBLISHERS p ON t.pub_id=p.pub_id

--- Challenge 2 - Who Have Published How Many At Where?

SELECT a.au_id "AUTHOR ID", a.au_lname "LAST NAME", a.au_fname "FIRST NAME", p.pub_name "PUBLISHER", COUNT(T.TITLE) "TITLE"
FROM AUTHORS a 
JOIN TITLEAUTHOR ta ON a.au_id=ta.au_id
JOIN TITLES t ON ta.title_id=t.title_id
JOIN PUBLISHERS p ON t.pub_id=p.pub_id
GROUP BY a.au_id, a.au_lname,a.au_fname,p.pub_name
ORDER BY a.au_id DESC
