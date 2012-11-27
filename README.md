As developers, we value our time. Sometimes you just want to get going on a project, without having to go through the same set up process over and over again. Download that third party library for the 100th time, include a file for the 100th time, type that boilerplate code yet again. Sometimes we want to have a simple way to create a project template that we can reuse later on. Templ is a command-line tool that allows you to do just that. Just point templ to any existing directory to designate that directory as a template. You can then call up that template whenever you want.

Templ is the easiest way to store language-agnostic templates on your Mac.

Using it is easy. There are only five commands.

templ - Lists all of your saved templates
templ create directory name - Creates a new template
templ delete name - Deletes a template
templ init name - Initializes one of your saved templates.
templ help - Help menu. 

Installation is easy too.

ruby -e "$(curl -fsSkL raw.github.com/prettymuchbryce/templ/src/install.rb)"

Getting help is - you guessed it, easy.

Just open an issue, or send me an email brycedneal@gmail.com