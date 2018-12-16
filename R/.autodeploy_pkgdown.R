travis::use_travis_deploy()

repo <- "kwb.orcid"

temp_dir <- tempdir()

fs::dir_create(temp_dir)

cmd <- c(sprintf("cd %s", temp_dir), 
         sprintf("git clone https://github.com/kwb-r/%s", repo),
         sprintf("cd %s", repo),
  "git checkout --orphan gh-pages", 
  "git rm -rf .", 
  "git commit --allow-empty -m 'Initial gh-pages commit'", 
  "git push origin gh-pages",
  "git checkout master")

writeLines(cmd, 
           "create_gh_pages.bat")


shell("create_gh_pages.bat", shell = "C:/Program Files/Git/git-cmd.exe" )
