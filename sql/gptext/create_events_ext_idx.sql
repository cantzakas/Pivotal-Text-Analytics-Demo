SELECT * FROM gptext.drop_index('events');

SELECT * FROM gptext.create_index_external('events');

SELECT
	* 
FROM 
	gptext.index_external(
		TABLE(
		SELECT
			IN_EVENTS.SOURCEURL
		FROM
			STAGING.IN_EVENTS IN_EVENTS, 
			STAGING.IN_EVENTS_PREPROC PREPROC
		WHERE
			IN_EVENTS.GLOBALEVENTID = PREPROC.GLOBALEVENTID
			AND PREPROC.URL_STATUS = 200 
		SCATTER BY IN_EVENTS.GLOBALEVENTID), 
		'events');

SELECT * FROM gptext.commit_index('events');

SELECT
	*
FROM
	gptext.search_external(TABLE(SELECT 1 SCATTER BY 1),
		'events', '*:*', null);
