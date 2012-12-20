#!/usr/bin/env ruby
#Templ 1.1
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

def does_directory_exist?(dir_name)
	found_dir = false

	templates_directory = Dir.entries(pwd())
	templates_directory.each do |dir|
		if File.directory?(dir)
			if dir == dir_name
				found_dir = true
			end
		end
	end

	if !found_dir
		error "Directory " + dir_name + " does not exist."
	end

	return found_dir
end

def get_templates()
	templates_directory = Dir.entries(TEMPLATE_FOLDER)
	templates = []
	templates_directory.each do |folder_name|
		if folder_name[0] != "."
			templates.push(folder_name)
		end
	end

	return templates
end

def delete_template(templ)
	rm_r(TEMPLATE_FOLDER+"/"+templ)
end

def does_template_exist?(templ,do_error)
	templates = get_templates()
	found_template = false
	templates.each do |template|
		if template == templ
			found_template = true
		end
	end

	if found_template == false
		if do_error
			error "Template " + templ + " does not exist."
		end
	end

	return found_template
end

def get_full_path_to_template(templ)
	return TEMPLATE_FOLDER+"/"+templ
end

def list
	templates = get_templates()

	if templates.length == 0
		puts "You have no saved templates."
	else
		templates.each do |template|
			puts template
		end
	end
end

def init(args)
	template_name = args[1]
	
	if !template_name
		puts "\033[31mMissing template name.\n\033[0mTry: templ init \033[34mkeyword"
		return
	end

	if does_template_exist?(template_name,true)
		cp_r(get_full_path_to_template(template_name),pwd())
		puts "Created template " + template_name + "."
	else
		return
	end
end

def create(args)
	dir_name = args[1]
	template_name = args[2]

	#validate
	if !dir_name
		puts "\033[31mMissing directory name.\n\033[0mTry: templ create \033[33mdirectory \033[34mkeyword"
		return
	elsif !template_name
		puts "\033[31mMissing template keyword.\n\033[0mTry: templ create \033[33mdirectory \033[34mkeyword"
	end

	if does_template_exist?(template_name,false)
		puts "\033[31mTemplate " + template_name + " already exists.\n\033[0mTry: templ update \033[33mdirectory \033[34mkeyword"
		return
	end

	if does_directory_exist?(dir_name)
		cp_r(dir_name, TEMPLATE_FOLDER)
		mv(TEMPLATE_FOLDER+"/"+dir_name, TEMPLATE_FOLDER+"/"+template_name)
		puts "Created template " + template_name + "."
	else
		return
	end
end

def delete(args)
	template_name = args[1]
	if does_template_exist?(template_name,true)
		delete_template(template_name)
		puts "Deleted template " + template_name + "."
	else
		return
	end
end

def update(args)
	dir_name = args[1]
	template_name = args[2]

	#validate
	if !dir_name
		puts "\033[31mMissing directory name.\n\033[0mTry: templ update \033[33mdirectory \033[34mkeyword"
		return
	elsif !template_name
		puts "\033[31mMissing template keyword.\n\033[0mTry: templ update \033[33mdirectory \033[34mkeyword"
	end

	if does_template_exist?(template_name,true)
		if does_directory_exist?(dir_name)
			delete_template(template_name)
			cp_r(dir_name, TEMPLATE_FOLDER)
			mv(TEMPLATE_FOLDER+"/"+dir_name, TEMPLATE_FOLDER+"/"+template_name)
			puts template_name + " updated."
		else
			return
		end
	else
		return
	end
end

def help
	puts "templ \t\t\t\t\t- Lists all of your saved templates\n"
	puts "templ create \033[33mdirectory \033[34mkeyword \033[0m\t\t- Creates and saves a new template\n"
	puts "templ init \033[34mkeyword \033[0m\t\t\t- Initializes one of your saved templates\n"
	puts "templ delete \033[34mkeyword \033[0m\t\t\t- Deletes a saved template\n"
	puts "templ update \033[33mdirectory \033[34mkeyword \033[0m\t\t- Updates an existing saved template\n"
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