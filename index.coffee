fs = require 'fs'
path = require 'path'
zlib = require 'zlib'

require 'colors'

loader = require './src/loader'
prompt = require './src/prompt'

HOME = if process.platform is 'win32' then process.env['USERPROFILE'] else process.env['HOME']

if process.argv.length < 3
	console.log "usage: jwalk <filename>"
	process.exit(1)

if fs.existsSync("#{HOME}/.jwalk")
    config = JSON.parse fs.readFileSync("#{HOME}/.jwalk")

if process.argv[2] == "-j" || process.argv[2] == "--json"
    jsonString = process.argv[3]

    loader.parse jsonString, (err, tree) ->
        if err?
            console.log "Error parsing JSON: #{err}".red
            process.exit(2)
        prompt.run(tree, config)

else if process.argv[2] == "-u" || process.argv[2] == "--url"
    url = process.argv[3]

    loader.getURL url, (err, tree) ->
        if err?
            console.log "Error getting JSON from url: #{err}".red
            process.exit(2)
        prompt.run(tree, config)

else
    filename = process.argv[2]
    if !fs.existsSync(filename)
    	console.log "File not found: #{filename}"
    	process.exit(1)

    loader.load filename, (err, tree) ->
    	if err?
    		console.log "Error loading file: #{err}".red
    		process.exit(2)
    	prompt.run(tree, config)
