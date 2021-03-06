require "./fez/*"
require "option_parser"
require "ecr/macros"

# Default Values
application_name = ""
application_directory = "."

# Parse the CLI options
OptionParser.parse! do |parser|
  parser.banner = "Usage: fez [arguments]"
  parser.on("-b NAME", "--build=NAME", "Set the NAME of the app") { |name| application_name = name }
  parser.on("-d DIR", "--directory=DIR", "Set the DIR where the app will be built") { |dir| application_directory = dir }
  parser.on("-v", "--version", "Fez version") { puts "Fez v#{Fez::VERSION}"; exit }
  parser.on("-h", "--help", "Show this help") { puts parser; exit }
end

if application_name == ""
  puts "You must specify an application name with the -b flag. View the help menu for more info."
  exit(1)
end

# Start the application
puts "Building #{application_name}"

new_app = Fez::Application.new(application_name)
new_app.build_directory(application_directory)
new_app.add_project_folders
new_app.add_project_files
new_app.add_initial_app_file
