# Katello Development Install
class katello_devel::install {

  package{ ['pulp-katello', 'libvirt-devel', 'sqlite-devel', 'postgresql-devel', 'libxslt-devel', 'libxml2-devel', 'git']:
    ensure => present
  }

  vcsrepo { "${katello_devel::deployment_dir}/foreman":
    ensure    => present,
    provider  => git,
    source    => 'https://github.com/theforeman/foreman.git',
    user      => $katello_devel::user,
    remote    => "upsream",
  }

  vcsrepo { "${katello_devel::deployment_dir}/katello":
    ensure    => present,
    provider  => git,
    source    => 'https://github.com/Katello/katello.git',
    user      => $katello_devel::user,
    remote    => "upsream",
  }

  exec { "katello_prs":
    command => "git config --add remote.origin.fetch '+refs/pull/*/head:refs/remotes/origin/pr/'",
    cwd     => "${katello_devel::deployment_dir}/foreman",
    user      => $katello_devel::user,
  }

  exec { "foreman_prs":
    command => "git config --add remote.origin.fetch '+refs/pull/*/head:refs/remotes/origin/pr/'",
    cwd     => "${katello_devel::deployment_dir}/foreman"
    user    => $katello_devel::user,
  }

}
