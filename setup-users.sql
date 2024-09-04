    CREATE USER IF NOT EXISTS 'webuser1'@'%' IDENTIFIED BY 'webuser1';
        GRANT SELECT ON mydatabase.product TO 'webuser1'@'%' ;
        GRANT INSERT, UPDATE ON mydatabase.customer TO 'webuser1'@'%';

    CREATE USER IF NOT EXISTS 'webuser2'@'%' IDENTIFIED BY 'webuser2';
      GRANT SELECT ON mydatabase.* TO 'webuser2'@'%';
      
     