CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;

-------------------------------------------------------------
-- PLEASE DO NOT CHANGE ANY SQL STATEMENTS ABOVE THIS LINE --
-------------------------------------------------------------

-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT name, size FROM dogs, sizes 
  WHERE height > min AND height <= max;

-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT child FROM dogs, parents 
  WHERE name = parent ORDER BY height DESC;

-- Filling out this helper table is optional
CREATE TABLE siblings AS
  SELECT d1.name AS name1, d2.name AS name2, d1.height AS height1, d2.height AS height2
  FROM dogs AS d1, dogs AS d2, parents AS p1, parents AS p2
  WHERE d1.name = p1.child AND d2.name = p2.child AND p1.parent = p2.parent
    AND d1.name <> d2.name AND d1.name < d2.name;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT name1 || " and " || name2 || " are " || size || " siblings"
  FROM siblings, sizes
  WHERE height1 > min AND height1 <= max and height2 > min AND height2 <= max;

-- Ways to stack 4 dogs to a height of at least 170, ordered by total height
CREATE TABLE stacks_helper(dogs, stack_height, last_height);

-- Add your INSERT INTOs here

INSERT INTO stacks_helper 
  SELECT name, height, height 
  FROM dogs;

INSERT INTO stacks_helper
  SELECT a.dogs || ", " || b.name, a.stack_height + b.height, b.height 
  FROM stacks_helper AS a, dogs AS b
  WHERE a.last_height < b.height;

INSERT INTO stacks_helper
  SELECT a.dogs || ", " || b.name, a.stack_height + b.height, b.height
  FROM stacks_helper AS a, dogs AS b
  WHERE a.last_height < b.height;

INSERT INTO stacks_helper
  SELECT a.dogs || ", " || b.name, a.stack_height + b.height, b.height
  FROM stacks_helper AS a, dogs AS b
  WHERE a.last_height < b.height;

CREATE TABLE stacks AS
  SELECT dogs, stack_height
  FROM stacks_helper
  WHERE stack_height > 170
  ORDER BY stack_height;