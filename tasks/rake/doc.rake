require File.expand_path('../../env', __FILE__)

task :doc_prep do
  output_dir = "#{RESULTS}/doc"
  manifest_dir = "#{RESULTS}/manifests"
    
  if File.directory?(output_dir)
    FileUtils.rm_r output_dir 
  end
  if File.directory?(manifest_dir)
    FileUtils.rm_r manifest_dir
  end
  FileUtils.mkdir_p manifest_dir
end

# TODO: Revisit this when/if it becomes available in Puppet Faces 
desc "Create puppet module documentation."
task :doc => [:doc_prep] do
  puts "Generating puppet module documentation..."

  output_dir = "#{RESULTS}/doc"
  manifest_dir = "#{RESULTS}/manifests"
    
  sh %{puppet doc --mode rdoc --manifestdir #{manifest_dir} --modulepath ../ --outputdir #{output_dir}}

  work_dir = File.dirname(__FILE__)
  parent_dir = File.dirname(work_dir)

  if File.directory? "#{output_dir}/files/#{work_dir}"
    FileUtils.mv "#{output_dir}/files/#{work_dir}", "#{output_dir}/files"
  end

  FileList["#{output_dir}/**/*.html"].each do |fn|
    text = File.read(fn)
    replace = text.gsub(%r(#{parent_dir}), "")
    File.open(fn, "w") { |file| file.puts replace }
  end

  FileList["#{output_dir}/files/**/*_pp.html"].each do |fn|
    depth_below_doc = fn.split(/\//).length - 3
    original_string = /[\.\/]*rdoc-style.css/
    replacement_string = '../' * depth_below_doc + 'rdoc-style.css'
    text = File.read(fn)
    replace = text.gsub(original_string, replacement_string)
    File.open(fn, "w") { |file| file.puts replace }
  end
end
