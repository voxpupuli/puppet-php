require File.expand_path('../../env', __FILE__)

desc "Check puppet module code style."
task :style do
  begin
    require 'puppet-lint'
  rescue LoadError
    fail 'Cannot load puppet-lint, did you install it?'
  end

  puts "Checking puppet module code style..."

  success = true

  linter = PuppetLint.new
  linter.configuration.log_format =
      '%{path}:%{linenumber}:%{check}:%{KIND}:%{message}'

	lintrc = "#{MODULE_ROOT_DIR}/.puppet-lintrc"
  if File.file?(lintrc)
    File.read(lintrc).each_line do |line|
      check = line.sub(/--no-([a-zA-Z0-9_]*)-check/, '\1').chomp
      linter.configuration.send("disable_#{check}")
    end
  end

  FileList['**/*.pp'].each do |puppet_file|
    puts "Evaluating code style for #{puppet_file}"
    linter.file = puppet_file
    linter.run
    success = false if linter.errors?
  end

  abort "Checking puppet module code style FAILED" if success.is_a?(FalseClass)
end
