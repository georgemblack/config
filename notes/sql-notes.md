# SQL Notes
## Creating a Table
### Primary and Unique Keys

Create a table named 'Author', with a first and last name.

	CREATE TABLE Author(
		authorid INTEGER PRIMARY KEY,
		firstname CHAR(20),
		lastname CHAR(30)
	);

A **primary key** is a minimal subset of attributes that is a unique identifier of tuples in a relation.

A **unique key** uniquely defines a row.

	CREATE TABLE Author(
		authorid INTEGER UNIQUE,
		firstname CHAR(20)
	);

There can only be one primary key, but many unique keys.

### Foreign Keys

Ensures author of book exists in author table.

	CREATE TABLE Book(
		bookid INTEGER PRIMARY KEY,
		title TEXT,
		authorid INTEGER,
		FOREIGN KEY (authorid) REFERENCES Author(authorid)
	);

### Enforcing Foreign-Key Constraints

There are two options to enforce foreign key constraints, without letting tuples dangle. (Book with `authorid` that doesn't exist, for example.)

1. Insertion/deletion/update query is rejected
2. Cascade update/delete
3. Set `NULL`

When a tuple referenced is updated, update propagates to the tuples that reference it.

	CREATE TABLE Book(
		bookid INTEGER PRIMARY KEY,
		title TEXT,
		authorid INTEGER,
		FOREIGN KEY (authorid) REFERENCES Author(authorid)
		ON [UPDATE/DELETE] CASCADE
	);

We can also set values to `NULL`.

	CREATE TABLE Book(
		bookid INTEGER PRIMARY KEY,
		title TEXT,
		authorid INTEGER,
		FOREIGN KEY (authorid) REFERENCES Author(authorid)
		ON [UPDATE/DELETE] SET NULL
	);

### Asserting Non-Null Values

To assert that a specific attribute cannot maintain `NULL` values:

	CREATE TABLE Author(
		authorid INTEGER PRIMARY KEY,
		firstname CHAR(20) NOT NULL
	);

## Populating a Table

The general format for populating a table:

	INSERT INTO Author
	VALUES (001, 'Dan', 'Brown');

## Basic Queries

### Basic Query Structure

`SELECT` is our projection, it keeps only the specified attributes. `FROM` states the relation(s) we use in the query, and `WHERE` filters the tuples of the relation(s).

What can we use in the `WHERE` clause?

* Attribute names of relations
* Comparisons: `=, <>, <, >, <=, >=`
* Arithmetic: `+, -, /, *`
* `AND`, `OR`, and `NOT`
* Operations on strings
* Pattern matching: `s LIKE p`
* Special functions like comparing dates and times

### Distinct

`DISTINCT` will return distinct elements, removing duplicates. Otherwise you could have a multisite.

	SELECT [DISTINCT] Population
	FROM City
	WHERE Population >= '1000000'
	AND CountryCode = 'USA';

### Arithmetic Expressions

We can use arithmetic expressions.

	SELECT Name, (Population/1000) 
	FROM City
	WHERE Population >= '1000000';

### Renaming Attributes

We can also rename attributes.

	SELECT Name, (Population/1000) AS PopulationInThousands
	FROM City
	WHERE Population >= '1000000';

### Pattern Matching

Pattern matching. `%` refers to any sequence of characters, `_` refers to any single character. This search will look for `Monarchy` in a string.

	SELECT Name, GovernmentForm
	FROM Country
	WHERE GovernmentForm LIKE '%Monarchy%';

### Ordering

`ORDER BY` orders tuples by attribute in `DESC` or `ASC` order.

	SELECT Name, Population
	FROM City
	WHERE Population >= '1000000'
	ORDER BY Population DESC;

### Limits

`LIMIT` restricts the number of results. Usually used with `ORDER BY`.

	SELECT Name, Population
	FROM City
	ORDER BY Population DESC
	LIMIT 2;

### Multiple Relations

	SELECT C.Name
	FROM Country C, CountryLanguage L
	WHERE C.Code = L.CountryCode
	AND L.Language = 'Greek';

## Set Operators

Set operators work as follows:

	{subquery} INTERSECT/UNION/EXCEPT {subquery}

* `INTERSECT` returns tuples that belong in both.
* `UNION` returns tuples that being in either results.
* `EXCEPT` returns tuples that belong in first, not second.

We can also add `ALL` keyword:

* `INTERSECT ALL`: number of copies of each tuple is the minimum number of copies in subqueries.
* `UNION ALL`: number of copies of each tuple is sum of copies in subqueries.
* `EXCEPT ALL`: number of copies of each tuple is the difference (if positive) of number of copies in subqueries.

The schema of the subqueries must be the same.

## Nested Queries

Can be used in `FROM` and `WHERE` clauses. For example, find all countries with a city named Berlin:

	SELECT C.Name
	FROM Country C
	WHERE C.code = (
		SELECT C.CountryCode
		FROM City C
		WHERE C.name = 'Berlin'
	);

While using nested subqueries, we have set comparisons: `IN`, `NOT IN`, `EXISTS`, `NOT EXISTS`, `ANY`, and `ALL`.

Some examples.

Find all countries in Europe that have *some* city with population more than 5 million.

	SELECT C.Name
	FROM Country C
	WHERE C.Continent = 'Europe'
	AND C.Code IN (
		SELECT CountryCode
		FROM City
		WHERE Population > 5000000
	);

Another query that accomplishes the same task.

	SELECT C.Name
	FROM Country C
	WHERE C.Continent = 'Europe'
	AND EXISTS (
		SELECT *
		FROM City T
		WHERE T.Population > 5000000
		AND T.CountryCode = C.Code
	);

One more example.

	SELECT C.Name
	FROM Country C
	WHERE C.Continent = 'Europe'
	AND 5000000 <= ANY (
		SELECT T.Population
		FROM City T
		WHERE T.CountryCode = C.Code
	);


## Aggregation

`SUM`, `AVG`, `COUNT`, `MIN`, `MAX` can be applied to a column in a `SELECT` clause to product that aggregation on the column.

`COUNT(*)` simply counts the number of tuples.

	SELECT AVG(Population)
	FROM Country
	WHERE Continent = 'Europe';

We can also use `DISTINCT` to count the distinct number of tuples.

	SELECT COUNT (DISTINCT Language)
	FROM CountryLanguage;

## Grouping

We may use `GROUP BY`, then, the relation is grouped according to values of the specified attributes. Any aggregation (above) is applied **within each group**.

	SELECT Continent, COUNT(*)
	FROM Country
	GROUP BY Continent;

`GROUP BY` can be follwed by `HAVING` to filter which groups should be displayed.

	SELECT Language, COUNT(CountryCode) AS N
	FROM CountryLanguage
	WHERE Percentage >= 50
	GROUP BY Language
	HAVING N > 2
	ORDER BY N DESC;
