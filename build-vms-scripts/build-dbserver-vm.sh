# Update Ubuntu software packages.
      apt-get update
      
       # We create a shell variable MYSQL_PWD that contains the MySQL root password
      export MYSQL_PWD='mysqlroot_pw'

      # The next two lines set up answers to the questions
      # the package installer would otherwise ask ahead of it asking,
      # so our automated provisioning script does not get stopped by
      # the software package management system attempting to ask the
      # user for configuration information.

      echo "mysql-server mysql-server/root_password password $MYSQL_PWD" | debconf-set-selections 
      echo "mysql-server mysql-server/root_password_again password $MYSQL_PWD" | debconf-set-selections
      
      # Install the MySQL database server.
      apt-get -y install mysql-server

      # On normal VMs MySQL server will now be running, but starting the service explicitly even if it's started causes no warnings.
      service mysql start

      # Run some setup commands to get the database ready to use.
      # First create a database. Only if it does not exist.
      echo "CREATE DATABASE IF NOT EXISTS mydatabase;" | mysql

      # Then create a database user "dbserver" with the given password.
      echo "CREATE USER IF NOT EXISTS 'dbserver'@'%' IDENTIFIED BY 'dbserver_pw';" | mysql
      
      # Grant all permissions to the database user "dbserver" regarding the whole mysql server.
     echo "GRANT ALL PRIVILEGES ON *.* TO 'dbserver'@'%' WITH GRANT OPTION" | mysql
      
      
      # Set the MYSQL_PWD shell variable that the mysql command will
      # try to use as the database password ...
       export MYSQL_PWD='dbserver_pw'

       # ... and run all of the SQL within the setup-database.sql file and setup-users.sql file,
      #The mysql command specifies both the user to connect as (dbserver) and the database to use (mydatabase).

      cat /vagrant/database/setup-database.sql | mysql -u dbserver mydatabase

      cat /vagrant/database/setup-users.sql | mysql -u dbserver mydatabase

       # The dbserver VM can connect to the
      # database on the dbserver VM. Use of `sed` is pretty obscure,
      # but the net effect of the command is to find the line
      # containing "bind-address" within the given `mysqld.cnf`
      # configuration file and then to change "127.0.0.1" (meaning
      # local only) to "0.0.0.0" (meaning accept connections from any
      # network interface).
       sed -i'' -e '/bind-address/s/127.0.0.1/0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

      # We then restart the MySQL server to ensure that it picks up
      # our configuration changes.
       service mysql restart