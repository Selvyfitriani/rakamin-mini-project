## Rakamin Recruitment Mini Project

Name: Selvy Fitriani <br />

-------

### Problem Description
As a good backend engineer, you will have to build API services for a Messaging Feature
similar to how WhatsApp works. These are services of this API
1. Users can send a message to another user.
2. Users can list all messages in a conversation between them and another user.
3. Users can reply to a conversation they are involved with.
4. User can list all their conversations (if user A has been chatting with user C & D, the list for A will shows A-C & A-D)

### Prerequisites 
To run this application locally on your computer, here are some prerequisites you need:
1. Ruby 2.7 (https://www.ruby-lang.org/en/documentation/installation/)
2. MySQL 8.0 (https://dev.mysql.com/doc/refman/8.0/en/installing.html)
3. Postman (https://www.postman.com/downloads/)

The link suggested above is just for option, you can use your own source to install the prerequisites.

### Do it first
1. clone this repo <br />
`` git clone https://github.com/Selvyfitriani/rakamin-mini-project.git `` <br />

2. make a copy of env_example.rb and give name environment.rb. For linux user, you can use this command <br />
`` cp env_example.rb environment.rb``

After that, please adjust some env variables in that file.

### How to Run

#### Setup the Database
After you install MySQL, you can create database using SQL script in this repository (``database/schema.sql``)

1. Login into your MySQL <br />
`` mysql -u root -p `` <br />
Then, insert your password
2. Run the SQL Script <br />
`` source /path-to-root-project/database/schema.sql`` <br />
This script will create the database and insert some dummy data.

#### Install Dependencies
This command will install all dependencies in Gemfile <br />
``bundle install``

#### Run the Test Suite
Point your terminal to this repository root, then simply you can run the command below to run all the test. <br />
``rspec spec/`` <br />
Then, it will create a folder ``coverage`` and you can see the coverage detail in ``coverage\index.html``

#### Run the Application
To run this application, you just need to run this command in this repository root <br />
``ruby main.rb ``

If you done with this step, you can use the application through the Postman. 

#### Using the Existent Postman Collection
You don't need to create your own collection, you can use my collection to test this application. Here are the steps to use it:
1. Open Postman
2. Select "Import"
3. Select "Link"
4. Copy paste the postman collection link: https://www.getpostman.com/collections/0cc6e26471e40a14acb0
5. Click Continue

In that collection, there are 4 request to fulfill requirements number 1-4.

If there are any questions, feel free to reach me on selvyfiriani@gmail.com 
