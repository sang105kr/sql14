

SELECT bookname, publisher, concat(concat(PUBLISHER ,'-'),bookname)
  FROM book;


SELECT bookname, publisher, publisher || '-' || bookname
  FROM book;