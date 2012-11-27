#!/usr/bin/env ruby
#Templ 1.0 by Bryce Neal @prettymuchbryce
require 'fileutils'
require 'pathname'
include FileUtils

TEMPLATE_FOLDER = "/usr/local/templ"

if !File.directory?(TEMPLATE_FOLDER)
	mkdir(TEMPLATE_FOLDER)
end

def error text
	puts "\033[31m" + text
end

def ensureDirectoryExists(dirName)
	foundDir = false

	templatesDirectory = Dir.entries(pwd())
	templatesDirectory.each do |dir|
		if File.directory?(dir)
			if dir == dirName
				foundDir = true
			end
		end
	end

	if foundDir == false
		error "Directory " + dirName + " does not exist."
	end

	return foundDir
end

def getTemplates()
	templatesDirectory = Dir.entries(TEMPLATE_FOLDER)
	templates = []
	templatesDirectory.each do |folderName|
		if folderName[0] != "."
			templates.push(folderName)
		end
	end

	return templates
end

def deleteTemplate(templ)
	rm_r(TEMPLATE_FOLDER+"/"+templ)
end

def ensureTemplateExists(templ,doError)
	templates = getTemplates()
	foundTemplate = false
	templates.each do |template|
		if template == templ
			foundTemplate = true
		end
	end

	if foundTemplate == false
		if doError
			error "Template " + templ + " does not exist."
		end
	end

	return foundTemplate
end

def getFullPathToTemplate(templ)
	return TEMPLATE_FOLDER+"/"+templ
end

def list
	templates = getTemplates()

	if templates.length == 0
		puts "You have no saved templates."
	else
		templates.each do |template|
			puts template
		end
	end
end

def init(args)
	templateName = args[1]
	
	if !templateName
		puts "\033[31mMissing template name.\n\033[0mTry: templ init \033[34mname"
		return
	end

	if ensureTemplateExists(templateName,true)
		cp_r(getFullPathToTemplate(templateName),pwd())
		puts "Created template " + templateName + "."
	else
		return
	end
end

def create(args)
	dirName = args[1]
	templateName = args[2]

	#validate
	if !dirName
		puts "\033[31mMissing directory name.\n\033[0mTry: templ create \033[33mdirectory \033[34mname"
		return
	elsif !templateName
		puts "\033[31mMissing template name.\n\033[0mTry: templ create \033[33mdirectory \033[34mname"
	end

	if ensureTemplateExists(templateName,false)
		puts "\033[31mTemplate " + templateName + " already exists.\n\033[0mTry: templ update \033[33mdirectory \033[34mtemplateName"
		return
	end

	if ensureDirectoryExists(dirName)
		cp_r(dirName, TEMPLATE_FOLDER)
		mv(TEMPLATE_FOLDER+"/"+dirName, TEMPLATE_FOLDER+"/"+templateName)
	else
		return
	end
end

def delete(args)
	templateName = args[1]
	if ensureTemplateExists(templateName,true)
		deleteTemplate(templateName)
		puts "template " + templateName + " deleted."
	else
		return
	end
end

def update(args)
	dirName = args[1]
	templateName = args[2]

	#validate
	if !dirName
		puts "\033[31mMissing directory name.\n\033[0mTry: templ update \033[33mdirectory \033[34mname"
		return
	elsif !templateName
		puts "\033[31mMissing template name.\n\033[0mTry: templ update \033[33mdirectory \033[34mname"
	end

	if ensureTemplateExists(templateName,true)
		if ensureDirectoryExists(dirName)
			deleteTemplate(templateName)
			cp_r(dirName, TEMPLATE_FOLDER)
			mv(TEMPLATE_FOLDER+"/"+dirName, TEMPLATE_FOLDER+"/"+templateName)
			puts templateName + " updated."
		else
			return
		end
	else
		return
	end
end

def help
	puts "templ \t\t\t\t\t- Lists all templates.\n"
	puts "templ create \033[33mdirectory \033[34mname \033[0m\t\t- Creates a new template.\n"
	puts "templ init \033[34mname \033[0m\t\t\t- Init an existing template.\n"
	puts "templ delete \033[34mname \033[0m\t\t\t- Deletes an existing template.\n"
	puts "templ update \033[33mdirectory \033[34mname \033[0m\t\t- Replaces an existing template.\n"
end

args = []

ARGV.each do|a|
	args.push(a)
end

if args.length == 0
	list()
elsif args[0] == "init"
	init(args)
elsif args[0] == "create"
	create(args)
elsif args[0] == "delete"
	delete(args)
elsif args[0] == "update"
	update(args)
elsif args[0] == "help"
	help()
elsif args[0] == "list"
	list()
end