## Class monit
# manage and configure the monit service

class monit {
  class{'monit::install':} ->
  class{'monit::config':} ~>
  class{'monit::service':} ->
  Class['monit']
}

