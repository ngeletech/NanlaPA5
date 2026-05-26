### Tripistry

A travel package platform where travellers browse and compare

packages and agencies create and curate them.



##### Group Members - Role/Contribution



**Ngeletshedzo Mutwanamba u25039769**

Ngeletshedzo was assigned the team leader and she was responsible for the frontend o of  Task 5. She did the html, CSS, javascript and the UI interface and client-side validation.



**- Amira Ajanaku u25111699**

Amira was responsible for half  the backend of task 5 and did Task 2 which is the E(ER) diagram. The backend is the php logic and database queries, session handling, logins, prepared statements logic and server-side validation.



**- Ntsako Mabasa u25083784**

Ntsako did Task 1 and Task 6 which is the research and populated the database. She also made the PDF and the ReadMe.



**-  Livhuwani Munyai u25449029**

Livhu made the relational schema and created the tables and also the first few entries for the first tutor meeting. She also did task 7 which was query optimisation.



**-  Navela Hlungwani 25254686**

Navela did task 3 which is the relational mapping. He also did half of the backend with Amira.





**Requirements:**

\- XAMPP (Apache + PHP 8.0 or higher)

\- MariaDB 12.2 or higher

\- MySQL Workbench

\- Any modern web browser



&#x20;**Database Setup:**

1\. Open MySQL Workbench and connect to your MariaDB server

2\. Run this query:

&#x20;  CREATE DATABASE tripistry;

3\. Go to Server → Data Import

4\. Select Import from Self-Contained File

5\. Browse to tripistry\_final.sql from the submitted files

6\. Set Default Target Schema to tripistry

7\. Click Start Import



**Application Setup:**

1\. Install XAMPP from https://www.apachefriends.org/

2\. Start Apache in the XAMPP Control Panel

3\. Copy the project folder into your htdocs folder

&#x20;  4. Open config.php and update the following:

&#x20;  - host: 127.0.0.1

&#x20;  - database: tripistry

&#x20;  - username: root

&#x20;  - password: your MariaDB root password

&#x20;  - port: the port your MariaDB is running on





**How to Run:**

1\. Make sure Apache is running in XAMPP

2\. Make sure MariaDB is running

3\. Open your browser and go to:

&#x20;  http://localhost/tripistry or specifically to this project http://localhost/NanlaPA5/app/login.php




**How to navigate the application:**



When a user first gets to the website they have to login.

If they have not logged in, they can register as either a traveller or travel agency.

Once registered the website redirects back to the login page and you login with credentials you registered with.



As a traveller, it will take you to your dashboard where you can see your profile details,

recent bookings you made, the total bookings, number of upcoming trips and reviews you have.

You can navigate to Browse where you can view, filter and sort existing packages; after clicking the view details to get more information about the package, you can book that package.

You can navigate to Compare where you can view and compare packages after selection; after clicking the view details to get more information about the package, you can book that package.

You can navigate to My Bookings where you can view your past and upcoming bookings and leave a review.





As a travel agency, it will take you to your dashboard where you can see your profile details,

packages, recent bookings made on your packages, how many active packages, total bookings and group trips you have

as well as the average rating.

You can navigate to My Packages where you can view, create, update and delete your packages.

You can navigate to Group Trips where you can view, create, update and delete your group trips (

the functionality doesn't make sense as only one traveller can be part of a group trip).



**Test Accounts:**

Default Users:

Traveller:

Email - johnpierre@gmail.com

Password - JohnP@123



Traveller:

Email - dreamtravels@gmail.com

Password - DreamTrav@123



&#x20;**GitHub Repository:**

https://github.com/ngeletech/NanlaPA5

