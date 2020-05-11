/* count number of pushes between Jan 1 and Jan 5 using TABLE_DATE_RANGE */
SELECT COUNT(*) FROM (
  TABLE_DATE_RANGE([githubarchive:day.], 
    TIMESTAMP('2015-01-01'), 
    TIMESTAMP('2015-05-01')
  )) 
WHERE type = 'PushEvent'

/* count number of watches between Jan~Oct 2014 using TABLE_QUERY */
SELECT COUNT(*) FROM (
  TABLE_QUERY([githubarchive:month],
    'REGEXP_MATCH(table_id, r"^20140\d")'
  ))
WHERE type = 'WatchEvent'

/* count number of forks in 2012~2014 */
SELECT COUNT(*) FROM 
  [githubarchive:year.2012],
  [githubarchive:year.2013],
  [githubarchive:year.2014]
WHERE type = 'ForkEvent'
