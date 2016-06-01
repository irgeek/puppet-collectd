#== Class: collectd::plugin::ceph
#
# Class to manage ceph plugin for collectd 
# === Parameters
# [*ensure*]
#   ensure param for collectd::plugin type
# 
# [*daemons*]
#   array of ceph daemons to create config for (replace clustername, hostname as appropriate)
#   example: [ '[clustername]-osd.1', '[clustername]-osd.2', '[clustername]-osd.3', '[clustername]-mon.[hostname].asok' ]
#  
#
# [*longrunavglatency*] If enabled, latency values(sum,count pairs) are
#   calculated as the long run average - average since the ceph daemon was
#   started = (sum / count). i When disabled, latency values are calculated as
#   the average since the last collection = (sum_now - sum_last) / (count_now -
#   count_last).
#
# [*convertspecialmetrictypes*}
#   If enabled, special metrics (metrics that differ in type from similar
#   counters) are converted to the type of those similar counters.  This
#   currently only applies to filestore.journal_wr_bytes which is a counter for
#   OSD daemons. The ceph schema reports this metric type as a sum,count pair i
#   while similar counters are treated as derive types. When converted, the sum
#   is used as the counter value and is treated as a derive type. When
#   disabled, all metrics are treated as the types received from the ceph
#   schema.
# 
class collectd::plugin::ceph (
  $ensure                    = 'present',
  $longrunavglatency         = false,
  $convertspecialmetrictypes = true,
  $daemons,
) {

  include ::collectd

  validate_array($daemons)

  collectd::plugin { 'ceph':
    ensure  => $ensure,
    content => template('collectd/plugin/ceph.conf.erb'),
  }
}
