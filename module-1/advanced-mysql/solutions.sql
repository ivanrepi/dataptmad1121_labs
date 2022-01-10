--- Challenge 1 - Most Profiting Authors

-----> Step 1: Calculate the royalty of each sale for each author and the advance for each author and publication

SELECT 
ta.au_id, 
t.title_id, 
(t.advance * ta.royaltyper / 100) "advance",
(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) "sales_royalty"
FROM TITLEAUTHOR ta, TITLES t, sales s
WHERE ta.title_id=t.title_id and t.title_id=s.title_id

-----> Step 2: Aggregate the total royalties for each title and author

SELECT 
ta.au_id, 
t.title_id, 
SUM(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) "sales_royalty"
FROM TITLEAUTHOR ta, TITLES t, sales s
WHERE ta.title_id=t.title_id and t.title_id=s.title_id
GROUP BY ta.au_id, t.title_id

-----> Step 3: Calculate the total profits of each author

SELECT TOP 3
ta.au_id, 
t.title_id, 
SUM(t.advance * ta.royaltyper / 100) +
SUM(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) "profits"
FROM TITLEAUTHOR ta, TITLES t, sales s
WHERE ta.title_id=t.title_id AND t.title_id=s.title_id
GROUP BY ta.au_id, t.title_id
ORDER BY profits DESC


--- Challenge 2 - Alternative Solution (temporary table)
SELECT 
ta.au_id, 
t.title_id, 
(t.advance * ta.royaltyper / 100) "advance",
(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) "sales_royalty"
INTO #alternative
FROM TITLEAUTHOR ta, TITLES t, sales s
WHERE ta.title_id=t.title_id and t.title_id=s.title_id

SELECT TOP 3
au_id, title_id,
sum(advance) + sum (sales_royalty) "profit"
FROM #alternative
GROUP by au_id, title_id
ORDER BY profit DESC


--- Challenge 3: Permanent table

SELECT 
ta.au_id, 
t.title_id, 
(t.advance * ta.royaltyper / 100) "advance",
(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) "sales_royalty"
INTO profits
FROM TITLEAUTHOR ta, TITLES t, sales s
WHERE ta.title_id=t.title_id and t.title_id=s.title_id

SELECT TOP 3
au_id,
sum(advance) + sum (sales_royalty) "profit"
FROM profits
GROUP by au_id, title_id
ORDER BY profit DESC