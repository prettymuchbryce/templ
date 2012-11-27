# Templ

![Templ Icon](http://www.gettyicons.com/free-icons/101/alien-vs-predator/png/256/avp4_256.png)

As developers, we value our time. Sometimes you just want to get going on a project without having to find and download that third party library for the 100th time, or type that boilerplate code yet again. Sometimes we want to have a simple way to create a project template that we can reuse later on. Templ is a command-line tool that allows you to do just that. Just point templ to any existing directory to designate that directory as a template. You can then call up that template whenever you want.

_Templ is the easiest way to create and store language-agnostic templates on your Mac._

## Installation is easy.

	ruby -e "$(curl -fsSkL raw.github.com/prettymuchbryce/templ/master/src/install.rb)"

## Using it is easy too. There are only a handful of commands.

	templ 							- Lists all of your saved templates
	templ create directory name 	- Creates and saves a new template
	templ init name 				- Initializes one of your saved templates
	templ update directory name 	- Updates an existing saved template
	templ delete name 				- Deletes a saved template
	templ help 						- Help menu. 

Additionally, you can find all of your saved templates in /usr/local/templ

## Removing templ
This will remove all traces of templ. Any templates you have saved will be deleted.
	rm -rf /usr/local/templ
	rm /usr/local/bin/templ

## Getting help

Just open an issue, or send me an email brycedneal@gmail.com