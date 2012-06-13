sudo apt-get install curl

curl -L get.rvm.io | bash -s stable

echo INSTALLING RVM...
/home/vagrant/.rvm/scripts/rvm

echo INSTALLING LATEST RUBY
rvm install 1.9.3
rvm use 1.9.3

echo COMFIRM RUBY UPDATE.  THE FOLLOWING SHOULD SHOW RUBY VERSION AS 1.9.3...
ruby --version

