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

      # Does not hurt to start the service explicitly even if it's started.
      service mysql start


      # Run some setup commands to get the database ready to use.
      # First create a database.Only if it does not exist.

      echo "CREATE DATABASE IF NOT EXISTS mydatabase;" | mysql

      # Then create a database user "admin" with the given password.
      echo "CREATE USER IF NOT EXISTS 'admin'@'%' IDENTIFIED BY 'admin_pw';" | mysql
      
      # Grant all permissions to the database user "admin" regarding
      # the "mydatabase" database that we just created, above.
      echo "GRANT ALL PRIVILEGES ON mydatabase.* TO 'admin'@'%'" | mysql
      
      # Set the MYSQL_PWD shell variable that the mysql command will
      # try to use as the database password ...
      export MYSQL_PWD='admin_pw'

       # The mysql command specifies both the user to connect as (admin) and the database to use (mydatabase).

      cat /vagrant/database/setup-database.sql | mysql -u admin mydatabase

       # By default, MySQL only listens for local network requests,
      # i.e., that originate from within the dbserver VM. We need to
      # change this so that the webserver VM can connect to the
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