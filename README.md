

# ACME CORP: Ruby x Sinatra Project

## System setup before running
> System Requirements:

-Ruby version 2.6.x (check your ruby version by typing “ruby -v” in terminal)

-Bundler 2.0.2

***note: System install instructions assume you are using codio***

### 1 Clone the project git repository

Open the terminal and in the terminal type:

```bash
git clone git@git.shefcompsci.org.uk:com1001-2019-20/team08/project.git
```
And then enter your username and password for gitlab.

### 2 Install dependencies

To install dependencies, navigate into the root directory of the app using:
```bash
 	cd project 
```
If you type “ls” you should see folders and files, particularly a file that says rakefile.
Then type:
```bash
	Rake install
```	
This command will install all gem dependencies and create the database.

### 3 Running the app
To run the app, type the following command:
```bash
	Rake run
```
This will start the web server which is accessible at
```bash
 	https://your_codio_name-4567.codio.io/
```
Where ‘your_codio_name’ is the name of your specific codio domain.

***Note: you must include the “-4567” to access the program otherwise you might access the project directory instead.***
