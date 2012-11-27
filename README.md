# templ

Templ is a command-line tool that lets you specify any folder as a project template by assigning it a keyword. 

	templ create myfolder mykeyword

Behind the scenes, templ makes a copy of that folder and lets you go about your business. If you decide later on that you want to "paste" that directory, you can do so using the keyword you provided.

	templ init mykeyword

## Installation is easy.

	ruby -e "$(curl -fsSkL raw.github.com/prettymuchbryce/templ/master/src/install.rb)"

## Using it is easy too. There are only a handful of commands.

	templ 							- Lists all of your saved project templates
	templ create directory keyword 	- Creates and saves a new project template
	templ init keyword 				- Initializes one of your saved project templates
	templ update directory keyword 	- Updates an existing saved project template
	templ delete keyword 			- Deletes a saved project template
	templ help 						- Help menu. 

Additionally, you can find all of your saved project templates in /usr/local/templ if you want to edit them manually.

## Removing templ
This will remove all traces of templ. Any project templates you have saved will be deleted.

	rm -rf /usr/local/templ
	rm /usr/local/bin/templ

## Getting help

Just open an issue, or send me an email brycedneal@gmail.com