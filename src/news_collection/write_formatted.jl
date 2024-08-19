"""
Writes data to the quiron news database with the address `storage_address`.

# Arguments
- `formatted::Vector{Dict}`: Vector of dictionaries of formatted articles to fit the database structure.
- `storage_address::String`: Address of the storage database.
"""
function write_formatted(formatted, endpoint_dict)
    if (nrow(formatted)>0)
        conn = LibPQ.Connection(db_conn())

        LibPQ.load!(
            (
                uri = formatted.uri,
                url = formatted.url ,
                time = formatted.time,
                dataType = formatted.dataType,  
                eventUri = formatted.eventUri, 
                shares = formatted.shares,
                location = formatted.location, 
                wgt = formatted.wgt,
                isDuplicate = formatted.isDuplicate,  
                sim = formatted.sim,
                body = formatted.body,  
                image = formatted.image,   
                sentiment = formatted.sentiment,
                date = formatted.date,
                relevance = formatted.relevance,
                dateTimePub = formatted.dateTimePub,  
                source = formatted.source,
                lang = formatted.lang,  
                title = formatted.title,  
                dateTime = formatted.dateTime,
                authors = formatted.authors,
                categories = formatted.concepts 
            ),
            conn,
            "INSERT INTO $(endpoint_dict["news_table"]) (uri, url, time, dataType, eventUri, shares, location, wgt, isDuplicate, sim, body, image, sentiment, date, relevance, dateTimePub, source, lang, title, dateTime, authors, categories ) VALUES (\$1, \$2, \$3, \$4, \$5, \$6, \$7, \$8, \$9, \$10, \$11, \$12, \$13, \$14, \$15, \$16, \$17, \$18, \$19, \$20, \$21, \$22)
            ON CONFLICT (uri) DO UPDATE SET
                wgt = EXCLUDED.wgt,
                uri = EXCLUDED.uri,
                url = EXCLUDED.url ,
                time = EXCLUDED.time,
                dataType = EXCLUDED.dataType,  
                eventUri = EXCLUDED.eventUri, 
                shares = EXCLUDED.shares,
                location = EXCLUDED.location, 
                isDuplicate = EXCLUDED.isDuplicate,  
                sim = EXCLUDED.sim,
                body = EXCLUDED.body,  
                image = EXCLUDED.image,   
                sentiment = EXCLUDED.sentiment,
                date = EXCLUDED.date,
                relevance = EXCLUDED.relevance,
                dateTimePub = EXCLUDED.dateTimePub,  
                source = EXCLUDED.source,
                lang = EXCLUDED.lang,  
                title = EXCLUDED.title,  
                dateTime = EXCLUDED.dateTime,
                authors = EXCLUDED.authors,
                categories = EXCLUDED.categories 
            ;"
        );

        execute(conn, "COMMIT;")
    end
end

