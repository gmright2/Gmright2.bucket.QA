/* count of issues opened, closed, and reopened on 2019/01/01 */
SELECT event as issue_status, COUNT(*) as cnt FROM (
  SELECT type, repo.name, actor.login,
    JSON_EXTRACT(payload, '$.action') as event, 
  FROM `githubarchive.day.20190101`
  WHERE type = 'IssuesEvent'
)
GROUP by issue_status;
