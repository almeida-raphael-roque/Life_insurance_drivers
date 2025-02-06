# Drivers insurance coverage
## Real project to send automatic emails

**The main objective of the project is to send emails to all enterprise units that have not updated their drivers in the database, asking them to do so.**

### Solution

1) A SQL query was created to retrieve important information about the units and their drivers, while also inserting details about their vehicles and the coverage benefits provided by the truck insurance.

2) An ETL process was developed to extract the query from AWS Amazon Athena, process and transform the data, and update it in an Excel worksheet using Python libraries such as Pandas.

3) An integration with Outlook was implemented using the win32com.client library. Additionally, a customized email was crafted for each client whose total number of license plates exceeded the number of registered drivers, indicating that the respective unit needs to update its driver in the system.



