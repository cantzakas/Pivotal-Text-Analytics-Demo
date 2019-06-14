SELECT * FROM gptext.drop_index('events');

SELECT * FROM gptext.create_index_external('events');

SELECT
	* 
FROM 
	gptext.index_external(
		TABLE(SELECT SOURCEURL FROM staging.IN_EVENTS_TEST ORDER BY RANDOM() LIMIT 20 SCATTER BY GLOBALEVENTID), 
		'events');

SELECT * FROM gptext.commit_index('events');


SELECT
	*
FROM
	gptext.search_external(TABLE(SELECT 1 SCATTER BY 1),
		'events', '*:*', null);
