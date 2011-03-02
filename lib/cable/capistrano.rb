Capistrano::Configuration.instance(:must_exist).load do
  
  after 'deploy', 'cable:symlink'
  
  namespace :cable do 
    desc "links the most recent bundled cable gem to shared path."
    task :symlink do
      run "cd #{release_path} && ln -nfs `bundle list cable` /home/deploy/jardenlicensedproducts.com/shared/cable"
    end
  end
  
end